later = require 'later'
later.date.UTC()

HOURLY_MESSAGE =
  0: "00:00 JST. 改修工厂已更新"
  3: "03:00 JST. 演习已更新"
  5: "05:00 JST. 任务已更新"
  15: "15:00 JST. 演习已更新"

class Notifier
  constructor: (qqbot) ->
    @qqbot = qqbot
    @laters = []

  start: ->
    # schedule use UTC
    schedule = later.parse.cron("0,30,40,50 5,17 * * *")
    @laters.push later.setInterval(@pratice.bind(this), schedule)
    schedule = later.parse.cron("0 * * * *")
    @laters.push later.setInterval(@hourly.bind(this), schedule)

  stop: ->
    for later in @laters
      later.clear()

  pratice: ->
    group = @qqbot.get_group
      account: 2643320628
    @qqbot.send_message_to_group(group, "演习快刷新啦、赶紧打演习啦！")

  hourly: ->
    hour = (new Date().getUTCHours() + 9) % 24
    message = HOURLY_MESSAGE[hour]
    if message?
      group = @qqbot.get_group
        account: 2643320628
      @qqbot.send_message_to_group(group, message)

notifier = null

module.exports =
  init: (qqbot) ->
    notifier = new Notifier(qqbot)
    notifier.start()
  stop: (qqbot) ->
    notifier.stop()