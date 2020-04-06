class Api::MessagesController < ApplicationController
  def index
    def index
      # ルーティングでの設定によりparamsの中にgroup_idというキーでグループのidが入るので、これを元にDBからグループを取得する
      group = Group.find(params[:group_id])
      # ajaxで送られてくる最後のメッセージ(今ビューに表示されているメッセージ)のid番号を変数に代入
      last_message_id = params[:id].to_i 
      # 取得したグループでのメッセージ達から、idがlast_message_idよりも新しい(大きい)メッセージ達のみを取得
      @messages = group.messages.includes(:user).where("id > ?", last_message_id)  # 「?」はプレースホルダーと呼ばれ、第二引数で指定した値が置き換えられる
    end
  end
end

# 名前空間をつけることにより、同様のクラス名で名付けたクラスを作ってもそれらを区別することができます。
# 今回の場合はcontrollers/messages_controller.rbとcontrollers/api/messages_controller.rbが存在しますが、ディレクトリを分けているおかげで区別できます。

# ただし、プログラムがクラスを判別する際はどのディレクトリに入っているかでの判別はできないため、名前空間を利用するルールになっています。
# こうすることで、Railsは間違えることなく2つのコントローラを区別するようプログラムされています。