later = require 'later'
later.date.UTC()

# NOTICE: Remember to convert JST to UTC.
HOURLY_MESSAGE =
  0: "09:00 JST."
  1: "10:00 JST."
  2: "11:00 JST."
  3: "12:00 JST."
  4: "13:00 JST."
  5: "14:00 JST."
  6: "15:00 JST. 演习已更新"
  7: "16:00 JST."
  8: "17:00 JST."
  9: "18:00 JST."
  10: "19:00 JST."
  11: "20:00 JST."
  12: "21:00 JST."
  13: "22:00 JST."
  14: "23:00 JST."
  15: "00:00 JST. 改修工厂已更新"
  16: "01:00 JST."
  17: "02:00 JST."
  18: "03:00 JST. 演习已更新"
  19: "04:00 JST."
  20: "05:00 JST. 任务已更新"
  21: "06:00 JST."
  22: "07:00 JST."
  23: "08:00 JST."
MONTHLY_MESSAGE = "00:00 JST. Extra Operation 已刷新"

class Notifier
  constructor: (qqbot) ->
    @qqbot = qqbot
    @praticeSchedule = later.parse.cron("0,30,40,50 5,17 * * *")
    @hourlySchedule = later.parse.cron("0 * * * *")

  start: ->
    @praticeLater = later.setInterval(@praticeNotify.bind(this), @praticeSchedule)
    @hourlyLater = later.setInterval(@hourlyNotify.bind(this), @hourlySchedule)

  stop: ->
    @praticeLater.clear()
    @hourlyLater.clear()

  praticeNotify: ->
    group = @qqbot.get_group
      account: 2643320628
    @qqbot.send_message_to_group(group, "演习快刷新啦、赶紧打演习啦！")

  hourlyNotify: ->
    now = new Date()
    hour = now.getUTCHours()
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