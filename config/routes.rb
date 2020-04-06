Rails.application.routes.draw do
  # ログイン・新規登録で必要なルーティングが生成される。
  devise_for :users  
  root to: "groups#index"  # ルートパスへのアクセスがあったら、groups_controllerのindexアクションが呼び出される
  resources :users, only: [:index,:edit, :update]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }  # このルーティングが来たらjson形式でレスポンスするよう指定しています。
    end
  end
end
