LOWER = 2
UPPER = 7000
separator = new RegExp('[ \t]+')

module.exports = (content, send, robot, message) ->
  content = content.trim().toLowerCase()
  contents = content.split(separator)
  return unless contents.length > 0
  return unless contents[0] == '/roll'

  ranges = []
  for s, i in contents.slice(1, 5)
    n = parseInt(s)
    # Ignore all number after an invalid input.
    if Number.isNaN n
      break
    # Send help message on out of range
    else if not (LOWER <= n <= UPPER)
      return send("/roll 的有效范围为 #{LOWER} ~ #{UPPER}")
    # Valid number
    else
      ranges.push n
  if ranges.length == 0
    ranges = [100]

  rolls = ranges.map (n) -> "#{Math.ceil(Math.random() * n)}/#{n}"
  name = message.from_user.nick
  send("[roll] #{name}: #{rolls.join ', '}")
