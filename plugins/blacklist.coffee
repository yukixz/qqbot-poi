fs = require 'fs'
path = require 'path'

BLACKLIST = []
fs.readFile path.join(__dirname, 'blacklist.json'), (err, data) ->
  BLACKLIST = JSON.parse data

match = (text, keywords) ->
  for keyword in keywords
    if text.indexOf(keyword) >= 0
      return true
  return false

module.exports = (content, send, robot, message) ->
  return match(content.toLowerCase(), BLACKLIST)
