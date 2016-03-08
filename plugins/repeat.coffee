
QUEUE_SIZE = 8
REPEAT_COUNT = 3
queue = []

module.exports = (content, send, robot, message) ->
  text = content.trim()

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
