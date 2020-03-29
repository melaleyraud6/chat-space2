class MessagesController < ApplicationController
  # messagesコントローラの全てのアクションで@groupを利用できるようにするため。
  before_action :set_group


  def index
    # Messageモデルの新しいインスタンスである@messageを定義
    # メッセージを新規登録するときに必要
    @message = Message.new
    # グループに所属する全てのメッセージである@messagesを定義
    @messages = @group.messages.includes(:user)
    
  end

  def create
    @message = @group.messages.new(message_params)
    if @message.save  # メッセージが保存できたら
      redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
    else 
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  private
  
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

end
