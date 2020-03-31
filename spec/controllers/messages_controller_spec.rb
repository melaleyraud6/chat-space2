require 'rails_helper'

describe MessagesController do
  # 複数のexampleで同一のインスタンスを使いたい場合、letメソッドを利用
  # letメソッドは初回の呼び出し時のみ実行
  # 一度実行された後は常に同じ値が返って来るため、テストで使用したいオブジェクトの定義に適しています。
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  # メッセージ一覧を表示するアクションのテスト
  describe '#index' do
    # ログインしている場合
    context 'log in' do
      # beforeブロックの内部に記述された処理は、各exampleが実行される直前に、毎回実行されます。
      before do
        login user
        # messagesのルーティングはgroupsにネストされているため、group_idを含んだパスを生成します。そのため、getメソッドの引数として、params: { group_id: group.id }を渡しています。
        get :index, params: { group_id: group.id }
      end
    # この中にログインしている場合のテストを記述
      # アクション内で定義しているインスタンス変数があるか
      it 'assigns @message' do
        # be_a_newマッチャを利用することで、 対象が引数で指定したクラスのインスタンスかつ未保存のレコードであるかどうか確かめることができます。
        expect(assigns(:message)).to be_a_new(Message)
      end
      # アクション内で定義しているインスタンス変数があるか
      it 'assigns @group' do
        # eqマッチャを利用してassigns(:group)とgroupが同一であることを確かめることでテストできます。
        expect(assigns(:group)).to eq group
      end
      # 該当するビューが描画されているか
      it 'renders index' do
        expect(response).to render_template :index
      end
    end

    # ログインしていない場合
    context 'not log in' do
      before do
        get :index, params: { group_id: group.id }
      end
      # 意図したビューにリダイレクトできているか
      it 'redirects to new_user_session_path' do
        # redirect_toマッチャは引数にとったプレフィックスにリダイレクトした際の情報を返すマッチャ
        # 非ログイン時にmessagesコントローラのindexアクションを動かすリクエストが行われた際(ログインせずにパスを直接入力してリクエストする？)に、ログイン画面にリダイレクトするかどうかを確かめる記述
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  # メッセージを作成するアクションのテスト
  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }
    # paramsを定義しています。これは、擬似的にcreateアクションをリクエストする際に、引数として渡すためのもの
    # attributes_forはcreate、build同様FactoryBotによって定義されるメソッドで、オブジェクトを生成せずにハッシュを生成するという特徴があります。

    context 'log in' do
    # この中にログインしている場合のテストを記述
      before do
        login user
      end

      context 'can save' do
      # この中にメッセージの保存に成功した場合のテストを記述
        subject {    # expectの引数として、subjectを定義して渡しています。
          post :create,      # 「postメソッドでcreateアクションを擬似的にリクエストをした結果」という意味
          params: params
        }
        # ログインしているかつ、保存に成功した場合
        # メッセージの保存ができているのかどうか
        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
          # changeマッチャは引数が変化したかどうかを確かめるために利用できるマッチャ
          # change(Message, :count).by(1)と記述することによって、Messageモデルのレコードの総数が1個増えたかどうかを確かめることができます。保存に成功した際にはレコード数が必ず1個増えるため、このようなテストとなります。
        end
        # 意図した画面に遷移しているかどうか
        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end
      # ログインしているかつ、保存に失敗した場合
      context 'can not save' do
      # この中にメッセージの保存に失敗した場合のテストを記述
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, body: nil, image: nil) } }
        # 擬似的にcreateアクションをリクエストする際にinvalid_paramsを引数として渡してあげることによって、意図的にメッセージの保存に失敗する場合を再現することができます。
        subject {
          post :create,
          params: invalid_params
        }
        # メッセージの保存は行われなかったかどうか
        it 'does not count up' do
          expect{ subject }.not_to change(Message, :count)
          # 「〜でないこと」を期待する場合にはnot_toを使用できます。
        end
        # 意図したビューが描画されているかどうか
        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end
    # ログインしていない場合
    context 'not log in' do
    # この中にログインしていない場合のテストを記述
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end



