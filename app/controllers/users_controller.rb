class UsersController < ApplicationController

  def index
    # jsのAjax関数の設定により、サーバーに入力した値が送られるので、適切なコントローラーで、値を含むデータをDBから取得するロジックを組みます。
    return nil if params[:keyword] == ""    # params[:keyword]に値が入っていればそのまま処理は続けられ、空だった場合はそこで処理が終わります。
    @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
                  # 入力された値を含むかつ、ログインしているユーザーのidは除外するという条件
    respond_to do |format|
      format.html
      format.json
    end
  end
  # editアクションでは必要になるインスタンス変数はないので、アクションを定義するだけで大丈夫です。
  def edit
  end


  # Userモデルの更新を行うupdateアクションは、保存できた場合、できなかった場合で処理を分岐しています。
  def update
    if current_user.update(user_params)   # 保存できた場合
      redirect_to root_path
    else                                  # できなかった場合編集画面に戻る
      render :edit
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
