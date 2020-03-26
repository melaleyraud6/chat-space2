# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      ## Database authenticatable データベースに保存されたパスワードが正しいかどうかの検証とを行ってくれます。また暗号化も同時に行うためセキュリティ面でも安心できます。
      t.string :name,               null: false, unique:true, index:true
      t.string :email,              null: false, unique:true, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable   パスワードをリセットするためのモジュールです。
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable   永続ログイン機能
      t.datetime :remember_created_at

      ## Trackable  サインイン回数、サインイン時間など、ユーザーの分析に必要なデータを保存しておく
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable 登録後メールを送り、そのメールのURLをクリックすると本登録が完了するといったような仕組み
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable  ログインに何度も失敗すると、アカウントをロックすることができる機能
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
