# Description:
#   Slack Help Center Links
#
# Commands:
#   hubot slackhelp - Displays all of the help center links.
#
# Notes:
#   These commands are grabbed from comment blocks at the top of each file.

helpLinks =
  """
よかったら、参考にしてみてね！

```
Slack Help Center Links.
・Slash Commands – Slack Help Center https://slack.zendesk.com/hc/en-us/articles/201259356-Slash-Commands
・Keyboard Shortcuts – cmd + ?

Help Request.
・nanapi Slack Request - https://nanapi.slack.com/help/requests/new
```
  """

module.exports = (robot) ->
  robot.respond /slackhelp$/i, (msg) ->
    msg.send helpLinks

  robot.hear /slackの使い方/i, (msg) ->
    msg.send helpLinks
