# Description:
#   Slack Custom SlashCommands
#
# Commands:
#   /latest_delete [full message]
#   /lgtm
#   /tiqav [text]
#   /bijint [options]
#
# URLS:
#   /slash_commands/lgtm
#   /slash_commands/tiqav
#   /slash_commands/bijint
#
# Notes:
#   Slackのスラッシュコマンド拡張

request = require 'request'
child_process = require('child_process').exec

module.exports = (robot) ->
  robot.router.get "/slash_commands/bijint", (req, res) ->
    if not req.query
      return

    if req.query.token != process.env.SLACK_BIJINT_TOKEN
      return

    user_id = req.query.user_id
    user_name = req.query.user_name
    reloadUserImages(robot, user_id)
    user_image = robot.brain.data.userImages[user_id]

    command = "bijint #{req.query.text}"
    child_process command, (err, stdout, stderr) ->
      if !err
        message = encodeURIComponent(stdout)
        postMessage = "https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%23#{req.query.channel_name}&text=#{message}&username=#{user_name}&link_names=1&pretty=1&icon_url=#{user_image}"
        request = robot.http(postMessage).get()
        request (err, res, body) ->

  robot.router.get "/slash_commands/latest_delete", (req, res) ->
    if not req.query
      return

    if req.query.token != process.env.SLACK_DELETE_TOKEN
      return

    message = encodeURIComponent("in:#{req.query.channel_name} from:#{req.query.user_name} #{req.query.text}")
    searchMessage = "https://slack.com/api/search.messages?token=#{process.env.SLACK_API_TOKEN}&query=#{message}&sort=timestamp&count=1&pretty=1"
    request = robot.http(searchMessage).get()
    request (err, res, body) ->
      json = JSON.parse body
      if json.messages.total > 0
        timestamp = json.messages.matches[0].ts
        username = json.messages.matches[0].username
        channel_id = json.messages.matches[0].channel.id
        if channel_id == req.query.channel_id && username == req.query.user_name
          deleteMessage = "https://slack.com/api/chat.delete?token=#{process.env.SLACK_API_TOKEN}&ts=#{timestamp}&channel=#{channel_id}"
          request = robot.http(deleteMessage).get()
          request (err, res, body) ->
      else
        request = robot.http("https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%40#{req.query.user_name}&text=%E5%89%8A%E9%99%A4%E5%AF%BE%E8%B1%A1%E3%81%8C%E8%A6%8B%E3%81%A4%E3%81%8B%E3%82%89%E3%81%AA%E3%81%8B%E3%81%A3%E3%81%9F%E3%82%8F%E3%82%88%EF%BC%81%E3%81%A7%E3%82%82%E3%80%81%E6%A4%9C%E7%B4%A2%E5%AF%BE%E8%B1%A1%E3%81%AB%E3%81%AA%E3%82%8B%E3%81%BE%E3%81%A7%E6%99%82%E9%96%93%E3%81%8C%E3%81%8B%E3%81%8B%E3%82%8B%E3%81%8B%E3%82%89%E3%80%81%E3%82%82%E3%81%86%E4%B8%80%E5%BA%A6%E8%A9%A6%E3%81%97%E3%81%A6%E3%81%BF%E3%81%AA%E3%81%95%E3%81%84%E3%81%AA%E3%80%82%E3%81%95%E3%81%81%E3%80%81%E8%AB%A6%E3%82%81%E3%81%9A%E6%B6%88%E3%81%99%E3%81%AE%E3%81%A7%E3%81%99%EF%BC%81&username=%E3%83%95%E3%83%AA%E3%83%BC%E3%82%B6%E6%A7%98&link_names=1&icon_emoji=%3Afreza%3A&pretty=1").get()
        request (err, res, body) ->

  robot.router.get "/slash_commands/lgtm", (req, res) ->
    if not req.query
      return

    if req.query.token != process.env.SLACK_LGTM_TOKEN
      return

    user_id = req.query.user_id
    user_name = req.query.user_name
    reloadUserImages(robot, user_id)
    user_image = robot.brain.data.userImages[user_id]

    robot.http("http://www.lgtm.in/g").header('Accept', 'application/json').get() (error, response, body) ->
      json = JSON.parse body
      message = json.imageUrl
      message = encodeURIComponent(message)

      postMessage = "https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%23#{req.query.channel_name}&text=#{message}&username=#{user_name}&link_names=1&pretty=1&icon_url=#{user_image}"
      request = robot.http(postMessage).get()
      request (err, res, body) ->

  robot.router.get "/slash_commands/tiqav", (req, res) ->
    if not req.query.text
      return

    if req.query.token != process.env.SLACK_TIQAV_TOKEN
      return

    user_id = req.query.user_id
    user_name = req.query.user_name
    reloadUserImages(robot, user_id)
    user_image = robot.brain.data.userImages[user_id]

    robot.http("https://d942scftf40wm.cloudfront.net/search.json?q=#{req.query.text}").header('Accept', 'application/json').get() (error, response, body) ->
      json = JSON.parse body
      pick = json[Math.floor(Math.random()*json.length)];
      message = "#{req.query.text} https://img.tiqav.com/#{pick.id}.#{pick.ext}"
      message = encodeURIComponent(message)

      postMessage = "https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%23#{req.query.channel_name}&text=#{message}&username=#{user_name}&link_names=1&pretty=1&icon_url=#{user_image}"
      request = robot.http(postMessage).get()
      request (err, res, body) ->

  reloadUserImages = (robot, user_id) ->
    robot.brain.data.userImages = {} if !robot.brain.data.userImages
    robot.brain.data.userImages[user_id] = "" if !robot.brain.data.userImages[user_id]?

    return if robot.brain.data.userImages[user_id] != ""
    options =
      url: "https://slack.com/api/users.list?token=#{process.env.SLACK_API_TOKEN}&pretty=1"
      timeout: 2000
      headers: {}

    request options, (error, response, body) ->
      json = JSON.parse body
      i = 0
      len = json.members.length

      while i < len
        image = json.members[i].profile.image_48
        robot.brain.data.userImages[json.members[i].id] = image
        ++i
