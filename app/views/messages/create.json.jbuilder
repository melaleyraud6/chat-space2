json.body @message.body
json.image @message.image_url
json.created_at @message.created_at.strftime("%Y年%m月%d日(%a) %H時%M分")
json.user_name @message.user.name
json.id @message.id   # 自動更新の際にidが必要になる