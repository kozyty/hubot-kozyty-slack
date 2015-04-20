# Description:
#   特定の禁則事項が発生した際にユーザにダイレクト通知する
#
# Notes:
#   #readonly でのコミュニケーションに反応してゆるく通知する

request = require 'request'
module.exports = (robot) ->
  robot.hear /.*?/i, (msg) ->
    channel = msg.envelope.room
    return if channel != "readonly"
    return if /@channel/.test msg.message.text
    username = msg.message.user.name
    request = msg.http("https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%40#{username}&text=%23readonly%20%E3%81%A7%E3%81%AF%20%40channel%20%E3%82%92%E4%BB%98%E3%81%91%E3%81%9F%E9%80%A3%E7%B5%A1%E4%BA%8B%E9%A0%85%E3%81%AE%E3%81%BF%E3%81%A7%E3%81%99%E3%82%88%E3%80%82%E3%81%95%E3%81%81%E8%A1%8C%E3%81%8D%E3%81%BE%E3%81%99%E3%82%88%E3%80%82%E3%82%B6%E3%83%BC%E3%83%9C%E3%83%B3%E3%81%95%E3%82%93%E3%80%81%E3%83%89%E3%83%89%E3%83%AA%E3%82%A2%E3%81%95%E3%82%93%E3%80%81%40#{username}%20%E3%81%95%E3%82%93%E3%80%82&username=%E3%83%95%E3%83%AA%E3%83%BC%E3%82%B6%E6%A7%98&link_names=1&icon_emoji=%3Afreza%3A&pretty=1").get()
    request (err, res, body) ->

