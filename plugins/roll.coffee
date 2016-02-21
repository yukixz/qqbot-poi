module.exports = (content, send, robot, message) ->
  content = content.toLowerCase()
  contents = content.split(' ')
  return if contents.length == 0

  if contents[0].match('^/roll$')
    rangeStr = contents[1]
    rangeStr ?= "100"
    range = parseInt(rangeStr)
    if range.toString() == rangeStr and 2 <= range <= 7000
      name = message.from_user.nick
      send("[roll] #{name}: #{Math.ceil(Math.random() * range)} / #{range}")
    else
      send("/roll 的有效范围为 2 ~ 7000")
    
