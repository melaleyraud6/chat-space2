class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # NOT NULL制約では空の文字列は保存可能なため、validatesを使用します。
  # 空の文字列の場合もエラーが発生する様にしてください
  validates :name, presence: true, uniqueness:true
end
