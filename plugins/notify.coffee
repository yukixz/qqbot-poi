later = require 'later'
later.date.UTC()

# NOTICE: Remember to convert JST to UTC.
HOURLY_MESSAGE =
  0: "09:00 AM JST."
  1: "10:00 AM JST."
  2: "11:00 AM JST."
  3: "12:00 AM JST."
  4: "01:00 PM JST."
  5: "02:00 PM JST."
  6: "03:00 PM JST. 演习已刷新"
  7: "04:00 PM JST."
  8: "05:00 PM JST."
  9: "06:00 PM JST."
  10: "07:00 PM JST."
  11: "08:00 PM JST."
  12: "09:00 PM JST."
  13: "10:00 PM JST."
  14: "11:00 PM JST."
  15: "12:00 PM JST."
  16: "01:00 AM JST."
  17: "02:00 AM JST."
  18: "03:00 AM JST. 演习已刷新"
  19: "04:00 AM JST."
  20: "05:00 AM JST. 任务已刷新"
  21: "06:00 AM JST."
  22: "07:00 AM JST."
  23: "08:00 AM JST."
MONTHLY_MESSAGE = "12:00 PM JST. Extra Operation 已刷新"

class Notifier
  constructor: (qqbot) ->
    @qqbot = qqbot
    @praticeSchedule = later.parse.cron("0,30,45,50,55 5,17 * * *")
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