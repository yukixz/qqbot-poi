
FAQ = [
  {
    keywords: ["下载"]
    whitelist: []
    message: "poi 下载地址\n百度网盘：http://0u0.moe/poi\nGithub: https://github.com/poooi/poi/releases"
  }
  {
    keywords: ["掉落", "统计", "哪里掉"]
    whitelist: []
    message: "poi-statistics # 掉落统计：\nhttp://db.kcwiki.moe/drop/"
  }
  {
    keywords: ["带路", "多少制空", "制空多少"]
    whitelist: []
    message: "请查询相关百科\n艦これ 攻略 Wiki http://wikiwiki.jp/kancolle/\n舰娘百科 http://zh.kcwiki.moe/"
  }

  {
    keywords: ["岛风go", "岛风狗", "锅go", "锅狗"]
    whitelist: ["不", "没"]
    message: "岛风go用户建议咨询岛风go客服"
  }
  {
    keywords: ["白屏"]
    whitelist: ["不", "没"]
    message: "请问用的是什么代理？"
  }
  {
    keywords: ["什么群", "啥群"]
    whitelist: []
    message: "poi 群"
  }

  {
    keywords: ["复读"]
    whitelist: []
    message: "人类的本质，只是一台复读机。"
  }
  {
    keywords: ["卡斩杀"]
    whitelist: []
    message: "洗脸刷闪上支援、或者切丙"
  }
  {
    keywords: ["死宅"]
    whitelist: []
    message: "四斋蒸鹅心"
  }
  {
    keywords: ["早安", "早上好"]
    whitelist: []
    message: "早安"
  }
  {
    keywords: ["午安", "中午好"]
    whitelist: []
    message: "午安"
  }
  {
    keywords: ["晚安"]
    whitelist: []
    message: "晚安"
  }
  {
    keywords: ["小鳖"]
    whitelist: ["傻", "笨", "白痴", "智障", "yuki", "喵"]
    message: "喵喵喵？"
  }
]
LAST_TRIGGER = []
THROTTLE = 10 * 1000

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
