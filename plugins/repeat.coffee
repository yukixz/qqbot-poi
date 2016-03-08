fs = require 'fs'
path = require 'path'

QUEUE_SIZE = 8
REPEAT_COUNT = 3
BLACKLIST = []


fs.readFile path.join(__dirname, 'repeat_blacklist.json'), (err, data) ->
  BLACKLIST = JSON.parse data

match = (text, keywords) ->
  for keyword in keywords
    if text.indexOf(keyword) >= 0
      return true
  return false

queue = []
module.exports = (content, send, robot, message) ->
  text = content.trim()
  return if match(text.toLowerCase(), BLACKLIST)

  # Find & remove matched message from queue.
  index = queue.findIndex (m) -> m.text == text
  msg = queue.splice(index, 1)[0] if index > -1

  # Increase message count
  msg ?=
    text: text
    count: 0
  msg.count += 1

  # Push message back to queue
  queue.push(msg)
  queue.shift() if queue.length > QUEUE_SIZE

  # Repeat message
  if msg.count == REPEAT_COUNT
    send(text)
