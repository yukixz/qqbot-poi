later = require 'later'

later.date.UTC()

class Notifier
  constructor: (qqbot) ->
    @qqbot = qqbot
    @praticeSchedule = later.parse.cron("0,30,45,50,55 5,17 * * *")

  start: ->
    @praticeLater = later.setInterval(@praticeNotify.bind(this), @praticeSchedule)

  stop: ->
    @praticeLater.clear()

  praticeNotify: ->
    group = @qqbot.get_group
      account: 2643320628
    @qqbot.send_message_to_group(group, "演习快刷新啦、赶紧打演习啦！")


notifier = null

module.exports =
  init: (qqbot) ->
    notifier = new Notifier(qqbot)
    notifier.start()
  stop: (qqbot) ->
    notifier.stop()