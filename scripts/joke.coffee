# Description:
#   Joke commands.
#
# Commands:
#   ぬるぽ - You reply with, "ｶﾞｯ" When you post a "ぬるぽ" word.
#
# Notes:
#   ネタ/ジョーク系のbot全般

bleach_poem = [
  "我等は 姿無き故に それを畏れ"
  "もし わたしが雨だったなら それが永遠に交わることのない 空と大地を繋ぎ留めるように 誰かの心を繋ぎ留めることができただろうか"
  "ぼくたちは ひかれあう 水滴のように 惑星のように ぼくたちは 反発しあう 磁石のように 肌の色のように"
  "剣を握らなければ おまえを守れない 剣を握ったままでは おまえを抱き締められない"
  "そう、我々に運命などない 無知と恐怖にのまれ 足を踏み外したものたちだけが 運命と呼ばれる濁流の中へと 堕ちてゆくのだ"
  "我々は涙を流すべきではない それは心に対する肉体の敗北であり 我々が心というものを 持て余す存在であるということの 証明にほかならないからだ"
  "錆びつけば 二度と突き立てられず 掴み損なえば 我が身を裂く そう 誇りとは 刃に似ている"
  "ああ おれたちは皆 眼をあけたまま 空を飛ぶ夢を見てるんだ"
  "俺達は 手を伸ばす 雲を払い 空を貫き 月と火星は掴めても 真実には まだ届かない"
  "届かぬ牙に 火を灯す あの星を見ずに済むように この吭を裂いて しまわぬように"
  "我々が岩壁の花を美しく思うのは 我々が岩壁に足を止めてしまうからだ 悚れ無き その花のように 空へと踏み出せずにいるからだ"
  "誇りを一つ捨てるたび 我等は獣に一歩近づく 心を一つ殺すたび 我等は獣から一歩遠退く"
  "軋む軋む 浄罪の塔 光のごとくに 世界を貫く 揺れる揺れる 背骨の塔 堕ちてゆくのは ぼくらか空か"
  "ぼくは ただ きみに さよならを言う練習をする"
  "降り頻る太陽の鬣が 薄氷に残る足跡を消してゆく 欺かれるを恐れるな 世界は既に欺きの上にある"
  "血のように赤く 骨のように白く 孤独のように赤く 沈黙のように白く 獣の神経のように赤く 神の心臓のように白く 溶け出す憎悪のよう に赤く いてつく傷歎のように白く 夜を食む影のように赤く 月を射抜く吐息のように 白く輝き 赤く散る"
  "あなたの影は 密やかに 行くあての無い 毒針のように 私の歩みを縫いつける あなたの光は しなやかに 給水塔を打つ 落雷のように 私の命の源を断つ"
  "そう、何ものも わたしの世界を 変えられはしない"
  "美しきを愛に譬ふのは 愛の姿を知らぬ者 醜き愛に譬ふのは 愛を知ったと驕る者"
]

takasan = [
  "< スマイル！"
  "< 呼んだ？"
  "< あ、それいいですね！"
  "< 参考になります！"
]

progress = [
  'http://livedoor.blogimg.jp/matometters/imgs/4/c/4cc416b4.jpg'
  'http://forum.shimarin.com/uploads/default/3/5a6b5c05cceb7cf3.png'
  'http://37.media.tumblr.com/3497ded6d8b569cfe0d0152f8fc6bc9d/tumblr_mzyaeoXEIS1sckns5o1_500.jpg'
  'http://draque-ch.com/wp-content/uploads/2014/06/bf80ec2b93465957a856e13a131555be.jpg'
  'http://forum.shimarin.com/uploads/default/6/8b3c7003765d0f2e.jpg'
  'http://38.media.tumblr.com/31ab4065305e3607b951332dde32b789/tumblr_mrkrlyMMIU1sckns5o1_500.jpg'
]

brad_master_kill = [
  "ころす"
  "ぶっ殺す"
  "2回ころす"
  "殺したあと殺す"
  "マーリン？持ってないよ？"
  "ぐぬぬ・・・"
]

eastasianwidth = require 'eastasianwidth'

cheerio = require 'cheerio'
request = require 'request'
cronJob = require('cron').CronJob

strpad = (str, count) ->
  new Array(count + 1).join str

String::toArray = ->
  array = new Array
  i = 0

  while i < @length
    array.push @charAt(i)
    i++
  array

module.exports = (robot) ->
  robot.hear /ぬるぽ/, (msg) ->
    msg.send """
```
   Λ＿Λ     ＼＼
（  ・∀・）  | | ｶﾞｯ
 と     ）  | |
  Ｙ /ノ     人
   / ）    < >   _Λ  ∩
＿/し'   ／／  Ｖ｀Д´）/
（＿フ彡             / ←>> @#{msg.message.user.name}
```
  """

  robot.hear /うほほ/i, (msg) ->
    msg.send 'そんなに儲かっちゃうの！'

  robot.hear /bleach/i, (msg) ->
    msg.send msg.random bleach_poem

  robot.hear /なよ$/, (msg) ->
    robot.adapter.client.web.chat.postMessage(res.message.room, "< 弱く見えるぞ", {icon_url: "https://qiita-image-store.s3.amazonaws.com/222/20074/c9c07f06-3a6c-6cb4-1e81-5217b49a5184.png", pretty: true, username: "藍染惣右介"})

  robot.hear /霊圧/, (msg) ->
    robot.adapter.client.web.chat.postMessage(res.message.room, "< なん・・・だと・・・", {icon_url: "https://qiita-image-store.s3.amazonaws.com/222/20074/e162010c-a600-f002-7af0-b7ff93d55a0d.png", pretty: true, username: "黒崎一護"})

  robot.hear /卍解|挽回/, (res) ->
    robot.adapter.client.web.chat.postMessage(res.message.room, "https://qiita-image-store.s3.amazonaws.com/222/20074/14294047-7faf-1c13-ffd8-5ae3d18341be.jpeg", {icon_url: "https://qiita-image-store.s3.amazonaws.com/222/20074/e162010c-a600-f002-7af0-b7ff93d55a0d.png", pretty: true, username: "黒崎一護"})

  robot.hear /^(?=.*マーリン)(?=.*持って)/, (res) ->
    message = res.random brad_master_kill
    robot.adapter.client.web.chat.postMessage(res.message.room, message, {icon_emoji: ":bread_master:", pretty: true, username: "mura24"})

  robot.hear /進捗どうですか/, (msg) ->
    msg.send msg.random progress

  robot.hear /突然の(.*)$/i, (msg) ->
    message = msg.match[1].replace /^\s+|\s+$/g, ''
    return until message.length

    length = Math.floor eastasianwidth.length(message) / 2

    suddendeath = [
      "＿#{strpad '人', length + 2}＿"
      "＞　#{message}　＜"
      "￣Y#{strpad '^Y', length}￣"
    ]
    msg.send suddendeath.join "\n"
