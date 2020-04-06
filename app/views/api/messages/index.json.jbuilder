# 新規投稿があった場合は、投稿の内容をレスポンスできるようにします。
json.array! @messages do |message|
  json.body message.body
  json.image message.image.url
  json.user_name message.user.name
  json.created_at message.created_at.strftime("%Y年%m月%d日(%a) %H時%M分") # strftimeメソッドは日時データを指定したフォーマットで文字列に変換することができるメソッド
  json.id message.id
end