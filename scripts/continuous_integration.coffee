# Description:
#   Deploy commands.
#
# Commands:
#   nanapi_bot deploy :service :branch
#
# Notes:
#   TravisCI, CircleCi, Werckerなど外部サービスが絡むCI系
require 'date-utils'
request = require 'request'

module.exports = (robot) ->
  robot.respond /(deploy|release|build|job) ignition(.*?)$/i, (msg) ->
    branch = msg.match[2].trim() || "master"

    request = msg.http("https://circleci.com/api/v1/project/nanapi/ignition/tree/#{branch}?circle-token=#{process.env.CIRCLECI_API_TOKEN}")
    .headers(Accept: 'application/json')
    .post()
    request (err, res, body) ->
      msg.send "ジョブを開始したよー。経過はこちらで確認してね！\n#{JSON.parse(body).build_url}"

  robot.respond /(deploy|release|build|job) nanapi(.*?)$/i, (msg) ->
    branch = msg.match[2].trim() || "master"

    # 特定Channels以外ではリリースできない
    if process.env.DEPLOY_CHANNELS is msg.envelope.room

      # 指定時間外ではリリースできない 10-19
      date = new Date();
      hours = date.getHours();
      if 9 < hours < 19
        params =
          build_parameters:
            AUTO_DEPLOY: 'true'

        msg.http("https://circleci.com/api/v1/project/nanapi/nanapi/tree/#{branch}?circle-token=#{process.env.CIRCLECI_API_TOKEN}")
        .header('Accept', 'application/json')
        .header('Content-type', 'application/json')
        .post(JSON.stringify params) (err, res, body) ->
          msg.send "ジョブを開始したよー。経過はこちらで確認してね！\n#{JSON.parse(body).build_url}"
      else
        msg.send "リリースは10時〜19時の間でやってください＞＜"
    else
      msg.send "ごめんね。そのチャンネルではリリースできないの。詳しくはエンジニアのお兄さんたちに聞いてね！"
