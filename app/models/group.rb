class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  # has_manyの引数に「アソシエーションを組みたいテーブル名」を、:throughのバリューに「中間テーブル名」を指定します。
  validates :name, presence: true, uniqueness: true
end
