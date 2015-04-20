# Description:
#   GitHub絡みでローカル処理が必要なスクリプト
#

request = require 'request'
cronJob = require('cron').CronJob

getPullRequests = (msg, type) ->
  url = "https://api.github.com/repos/nanapi/ignition/pulls?state=open"
  options =
    url: url
    timeout: 2000
    headers: {'Authorization': "token #{process.env.GITHUB_API_TOKEN}", 'User-Agent': 'From Hubot in IGNITION'}

  text = ''
  request options, (error, response, body) ->
    json = JSON.parse(body)
    i = 0
    len = json.length

    if type == 'cron'
      text += "おはようございます★今日は#{len}件のPull Requestがあります！\n\n"

    while i < len
      title = json[i].title
      url = json[i]._links.html.href
      text += "- #{title}\n  #{url}\n\n"
      ++i
    if type == 'cron'
      text += "今日も一日がんばりましょー\n"

    request = msg.http("https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%23ignition_development&text=#{text}&username=nanapi_bot&icon_emoji=%3Ananapibot%3A&pretty=1").get()
    request (err, res, body) ->

module.exports = (robot) ->
  robot.respond /(pull_request|pr) ignition/i, (msg) ->
    getPullRequests(msg, 'request')

  new cronJob('0 0 10 * * 1-5',() ->
    getPullRequests(msg, 'cron')
  ).start()
