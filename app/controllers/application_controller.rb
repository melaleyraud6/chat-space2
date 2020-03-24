class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # 通常のテーブルに保存する際はストロングパラメータを使用しましたが、deviseを使ったモデルの場合は方法が異なります。
  # application_controllerにbefore_actionを使用しているため、全てのアクションが実行される前に、この部分が実行されることになります。
  before_action :authenticate_user!   # ログイン済ユーザーのみにアクセスを許可

  # deviseのコントローラーから呼び出された場合は、「configure_permitted_parameters」メソッドが呼ばれます。
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  # deviseをインストールすることでdevise_parameter_sanitizerのpermitメソッドが使えるようになりますが、これがストロングパラメータに該当する機能です。サインアップ時に入力された「name」キーの内容の保存を許可しています。
end
