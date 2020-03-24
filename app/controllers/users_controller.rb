class UsersController < ApplicationController
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
