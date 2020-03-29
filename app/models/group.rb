class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  # has_manyの引数に「アソシエーションを組みたいテーブル名」を、:throughのバリューに「中間テーブル名」を指定します。
  has_many :messages
  validates :name, presence: true, uniqueness: true

  def show_last_message
    # 最新のメッセージを変数last_messageに代入しつつ、メッセージが投稿されているかどうかで場合分けを行なっています。
    if (last_message = messages.last).present?  # lastメソッドは配列の要素を取り出すときその配列の中の最後の要素を取得メソッド
      if last_message.body?   #文章が投稿されている場合
        last_message.body
      else                    #画像が投稿されている場合
        "画像が投稿されています"
      end
    else
      "まだメッセージはありません"
    end
  end
end
