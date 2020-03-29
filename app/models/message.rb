class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user

  mount_uploader :image, ImageUploader            # Message.imageと、アップローダーImageUploaderとをひも付け。
  
  validates :body, presence: true, unless: :image? # imageカラムが空だったらbodyカラムが空だと保存しない
  
end
