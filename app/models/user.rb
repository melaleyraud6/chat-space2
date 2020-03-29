class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, # データベースに保存されたパスワードが正しいか検証をします。同時にパスワードの暗号化も行います。
          :registerable,             # User登録、編集、削除機能を作成することができます。
          :recoverable,              # パスワードをリセットします。
          :rememberable,             # 永続ログイン機能を作成することができます。
          :validatable               # Emailやパスワードのバリデーションを追加します。
  has_many :group_users
  has_many :groups, through: :group_users
  # NOT NULL制約では空の文字列は保存可能なため、validatesを使用します。
  # 空の文字列の場合もエラーが発生する様にしてください
  has_many :messages
  validates :name, presence: true, uniqueness:true
end
