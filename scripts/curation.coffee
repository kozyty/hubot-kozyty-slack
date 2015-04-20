# Description:
#   特定ワードキュレーション bot
#
# Notes:
#   特定ワードの投稿を、特定channelにキュレーションするbot

module.exports = (robot) ->

  # okaoka-ch
  robot.hear /(アプリ|おかおか|オカオカ|岡山さん|からあげ|唐揚げ|肉)/i, (msg) ->
    channel = msg.envelope.room
    message = msg.message.text
    username = msg.message.user.name
    if message.length > 0
      request = msg.http("https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%23okaoka-ch&text=%3E%20*#{message}*%20(from%20%40#{username}%20at%20%23#{channel}%20)&username=okaoka&link_names=1&icon_url=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fslack-files2%2Fbot_icons%2F2014-06-20%2F2406468061_48.png&pretty=1").get()
      request (err, res, body) ->

  # kozyty
  robot.hear /(こじてぃ|ｺｼﾞﾃｨ)/i, (msg) ->
    channel = msg.envelope.room
    message = msg.message.text
    username = msg.message.user.name
    if message.length > 0
      request = msg.http("https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=kozyty&text=%3E%20*#{message}*%20(from%20%40#{username}%20at%20%23#{channel}%20)&username=kozyty&link_names=1&pretty=1").get()
      request (err, res, body) ->

  # kintai
  robot.hear /(休み|おやすみ|休ま|出社|出勤|遅刻|遅延)/i, (msg) ->
    channel = msg.envelope.room
    message = msg.message.text
    username = msg.message.user.name
    if message.length > 0
      request = msg.http("https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%23kintai&text=%3E%20*#{message}*%20(from%20%40#{username}%20at%20%23#{channel}%20)&username=kintai_bot&link_names=1&pretty=1").get()
      request (err, res, body) ->
