fs = require 'fs'
path = require 'path'

FAQ = []
LAST_TRIGGER = []
THROTTLE = 10 * 1000

fs.readFile path.join(__dirname, 'faq.json'), (err, data) ->
  try
    FAQ = JSON.parse data
    for faq, i in FAQ
      LAST_TRIGGER[i] = 0
  catch err
    console.error "Failed to load faq.json", err

match = (content, keywords) ->
  for keyword in keywords
    if content.indexOf(keyword) >= 0
      return true
  return false

module.exports = (content, send, robot, message) ->
  content = content.toLowerCase()
  now = Date.now()
  for faq, i in FAQ
    if match(content, faq.keywords)
      if not match(content, faq.whitelist) and (now - LAST_TRIGGER[i]) > THROTTLE
        LAST_TRIGGER[i] = now
        send(faq.message)
      return
