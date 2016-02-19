fs = require 'fs'
path = require 'path'

FAQ = []
LAST_TRIGGER = []
THROTTLE = 10 * 1000

fs.readFile path.join(__dirname, 'faq.json'), (err, data) ->
  if err?
    console.error "Failed to load faq.json", err
    return
  try
    FAQ = JSON.parse data
  catch err
    console.error "Failed to load faq.json", err
for faq, i in FAQ
  LAST_TRIGGER[i] = 0

module.exports = (content, send, robot, message) ->
  content = content.toLowerCase()
  for faq, i in FAQ
    mKeyword = mWhitelist = false
    for kw in faq.keywords
      if content.indexOf(kw) >= 0
        mKeyword = true
        break
    for kw in faq.whitelist
      if content.indexOf(kw) >= 0
        mWhitelist = true
        break

    if mKeyword and not mWhitelist
      now = Date.now()
      break if (now - LAST_TRIGGER[i]) < THROTTLE
      LAST_TRIGGER[i] = now
      send(faq.message)
      return
