require 'rails_helper'
#----------------------------------------------------
# メッセージが保存できる場合
  # メッセージがあれば保存できる➀
  # 画像があれば保存できる➁
  # メッセージと画像があれば保存できる➂
#----------------------------------------------------
  # RSpec.describe  で、テストのグループ化を宣言。モデル名, type: model: で、モデルに関するテストであることを付け加えている。
  RSpec.describe Message, type: :model do
    describe '#create' do                           # createアクション時のテストであると宣言
      context 'can save' do                         # 特定の条件でテストをグループ分けしたい場合、contextを使うことができる
                                                    #（メッセージを保存できる場合のテストを記述）
        it 'is valid with body' do               # ➀
          expect(build(:message, image: nil)).to be_valid
        end
  
        it 'is valid with image' do                 # ➁
          expect(build(:message, body: nil)).to be_valid
        end
  
        it 'is valid with body and image' do     # ➂
          expect(build(:message)).to be_valid
        end
      end
#-----------------------------------------------------
# メッセージが保存できない場合
  # メッセージと画像が両方ない場合保存できない
  # group_idが無いと保存できない
  # user_idが無いと保存できない
#------------------------------------------------------
      context 'can not save' do
        # この中にメッセージを保存できない場合のテストを記述
          it 'is invalid without body and image' do
          # 画像もメッセージもない
            message = build(:message, body: nil, image: nil)
            message.valid?    # 作成したインスタンスがバリデーションによって保存ができない状態かチェック
            # 下記を表示する前にメッセージの検証を行う。
            expect(message.errors[:body]).to include("を入力してください")
            # error時の表示を設定する。
            # message.errors[:カラム名] でそのカラムが原因のエラー文が入った配列を取り出す(エラー文はrails内に自動で設定されている)
            # 上記で生成されたエラー文に"を入力されています"を含んでいる(include)場合テストにパスするといったコードである。
          end    

          it 'is invalid without group_id' do
            message = build(:message, group_id: nil)
            message.valid?
            expect(message.errors[:group]).to include("を入力してください")
          end

          it 'is invaid without user_id' do
            message = build(:message, user_id: nil)
            message.valid?
            expect(message.errors[:user]).to include("を入力してください")
          end
      end
    end
  end












