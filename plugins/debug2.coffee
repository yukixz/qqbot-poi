
fs = require('fs')
path = require('path')
RELOAD_CHECK = path.join(__dirname, "..", "reload.touch");

module.exports = (content, send, robot, message) ->
  contents = content.split(' ')
  return if contents.length == 0

  if content.match('^/reload$') and message.from_user.account == 412632991
    robot.dispatcher.reload_plugin()
    send("已重新加载")
    return

  if content.match('^/debug$')
    console.log("MESSAGE", JSON.stringify message)
