class GroupsController < ApplicationController
  def index
    
  end

  def new
    @group = Group.new  # form_forで使用するための変数
    @group.users << current_user
    # 配列に要素を追加するためのものです。
    # グループを新規作成する時はログイン中のユーザーを必ず含めたいためあらかじめ追加しておきます。
  end

  def create
    @group = Group.new(group_params)
    if @group.save  # グループが保存できたら
      redirect_to root_path, notice: "グループが作成しました" #ルートパスに遷移して,メッセージを表示
    else 
      render :new  # 保存ができなかったら新規登録画面を表示
    end
  end

  def edit
    @group = Group.find(params[:id]) #コントローラに送られたparams[:id]で編集したいグループを特定し表示するために変数に入れる
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to  group_messages_path(@group.id), notice: 'グループを更新しました'
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids:[])
  end
  # 配列に対して保存を許可したい場合は、キーの名称と関連づけてバリューに「[]」と記述します。
end
