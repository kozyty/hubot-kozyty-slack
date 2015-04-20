# Description:
#   random dog
#
# Configuration:
#   None
#
# Commands:
#   hubot dog me
#
# Author:
#   vexus2

cheerio = require('cheerio')

image_resources = [
  "http://dogsoftheinterwebs.tumblr.com/random"
]

module.exports = (robot) ->
  robot.respond /dog me/i, (msg) ->
    randomImage msg, robot, (url) ->
      msg.send url

randomImage = (msg, robot, cb) ->
  console.log msg.random(image_resources)
  robot.http(msg.random(image_resources))
    .get() (err, res, body) ->
      parse robot, res.headers.location, (location) ->
        cb location

parse = (robot, location, cb) ->
  robot.http(location)
    .get() (err, res, body) ->
      $ = cheerio.load(body)
      img = $('img', 'article').attr('src')
      cb img
