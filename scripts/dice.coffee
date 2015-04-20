# Description:
#   Utilities such as classification team decided the order
#
# Commands:
#   hubot dice - Replay with random number

module.exports = (robot) ->
  robot.respond /DICE$/i, (msg) ->
    result = parseInt(Math.random()*100)
    msg.send "ジャジャン！#{result}の目が出たよ！"
