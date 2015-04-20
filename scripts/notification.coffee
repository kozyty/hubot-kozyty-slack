# Description:
#   Support some notification commands from other bots.
#
# Notes:
#   各種Notificationからの通知サポート

Array::shuffle=->
    a=[@...]
    for i in [(a.length-1)..0] by -1
        p=(Math.random()*(i+1))|0
        [a[p],a[i]]=[a[i],a[p]]
    a

failed_comments = [
  'たいへん！テストが落ちたよ！'
  'こらっ！テストが落ちたよ！'
  'テストガ オチマシタ'
  'テストが落ちたみたい。焦らなくていいから確認してね！'
  'テストが落ちたみたい。あきらめたらそこで試合終了だよ'
]

leaving_comment = [
  'お疲れ様☆ジョブカン押した？気をつけて帰ってね！'
  '今日も一日お疲れ様♡ジョブカン押してから帰ってね！'
]

request = require 'request'

module.exports = (robot) ->
  robot.hear /.*?Failed.*?/, (msg) ->
    msg.send 'Failed'
#    message = "@channel @#{msg.match[1]} #{failed_comments.shuffle()[0]}"
#    payload =
#      message: message
#      content:
#        text: "Attachement Demo Text"
#        fallback: "Fallback Text"
#        pretext: "This is Pretext"
#        color: "#FF0000"
#        fields: fields
#    robot.emit 'slack-attachment', payload

module.exports = (robot) ->
  robot.hear /(アディオス|今日もお疲|退勤|ごきげんよ|グ[ッ]?バイ|本日の進捗報告|お先に失礼|お(つか|疲)れ(さま|様))/, (msg) ->
    return unless process.env.STAFF_NOTIFY_CHANNEL is msg.envelope.room
    username = msg.envelope.user.name
    message = "@#{username} #{leaving_comment.shuffle()[0]}"
    request = msg.http("https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%23#{process.env.STAFF_NOTIFY_CHANNEL}&text=#{message}&username=nanapi_bot&icon_emoji=%3Ananapibot%3A&pretty=1&link_names=1").get()
    request (err, res, body) ->
