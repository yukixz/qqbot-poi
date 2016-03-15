fs = require 'fs'
path = require 'path'

DEFAULT_INTERVAL = 60
FAQ = []

fs.readFile path.join(__dirname, 'faq.json'), (err, data) ->
  FAQ = JSON.parse data
  for faq, i in FAQ
    # TODO: check faq.keywords and faq.message
    faq.whitelist ?= []
    faq.interval ?= DEFAULT_INTERVAL
    faq.triggered = 0

match = (content, keywords) ->
  for keyword in keywords
    if content.indexOf(keyword) >= 0
      return true
  return false

module.exports = (content, send, robot, message) ->
  content = content.toLowerCase()
  now = Date.now()
  for faq, i in FAQ
    # If mismatch keywords, try next faq.
    continue if not match(content, faq.keywords)

    # If match whitelist or in colddown, end module.
    return true if match(content, faq.whitelist) or (now - faq.triggered) < (faq.interval * 1000)

    if faq.message instanceof Array
      message = faq.message[Math.floor(Math.random() * faq.message.length)]
    else
      message = faq.message

    faq.triggered = now
    send(message)
    return true
