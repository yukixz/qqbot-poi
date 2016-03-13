
QUEUE_SIZE = 20
REPEAT_COUNT_MIN = 2
REPEAT_COUNT_MAX = 4

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
    repeated: false
  msg.count += 1

  # Push message back to queue
  queue.push(msg)
  queue.shift() if queue.length > QUEUE_SIZE

  # Repeat message
  return if msg.repeated
  return unless REPEAT_COUNT_MIN <= msg.count <= REPEAT_COUNT_MAX
  if (Math.random() * (REPEAT_COUNT_MAX - msg.count + 1)) < 1
    msg.repeated = true
    send(msg.text)
    return true
