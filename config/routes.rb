Rails.application.routes.draw do
  # ログイン・新規登録で必要なルーティングが生成される。
  devise_for :users  
  
  root to: "groups#index"  # ルートパスへのアクセスがあったら、groups_controllerのindexアクションが呼び出される
  resources :users, only: [:edit, :update]
  resources :groups, only: [:index,:new, :create, :edit, :update]
  resources :messages, only: [:index]
end
