Rails.application.routes.draw do
  # ログイン・新規登録で必要なルーティングが生成される。
  devise_for :users  
  
  root to: "messages#index"  # ルートパスへのアクセスがあったら、messages_controllerのindexアクションが呼び出される
  resources :users, only: [:edit, :update]
end
