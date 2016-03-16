fs = require 'fs'
path = require 'path'

ADMIN = []
fs.readFile path.join(__dirname, 'admin.json'), (err, data) ->
  ADMIN = JSON.parse data

module.exports = (content, send, robot, message) ->
  return unless message.from_user.account in ADMIN
  contents = content.split(' ')
  return if contents.length == 0

  if content == '/reload'
    robot.dispatcher.reload_plugin()
    send("已重新加载插件")
    return true

  if content == '/stop'
    robot.dispatcher.stop_plugin()
    send("已停止所有插件")
    return true

  if content == '/debug'
    console.log("MESSAGE", JSON.stringify message)
    return true
