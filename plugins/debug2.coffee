
module.exports = (content, send, robot, message) ->
  return unless message.from_user.account in [412632991]
  contents = content.split(' ')
  return if contents.length == 0

  if content == '/reload'
    robot.dispatcher.reload_plugin()
    send("已重新加载")
    return

  if content == '/debug'
    console.log("MESSAGE", JSON.stringify message)
    return
