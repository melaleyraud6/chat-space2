$(function(){

  // 引数に値が入っていた場合                             「data属性」へ任意の値を保持させておくことで、あとからJavaScriptやjQueryで取得・変更できる
  function addUser(user){
    var html = `
              <div class="chat-group-user clearfix">
                <p class="chat-group-user__name">${user.name}</p>
                <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
              </div>
              `
    $("#user-search-result").append(html)
    // console.log(html);
  }
  // 引数に値が入っていなかった場合
  function addNoUser(user){   
    var html = `
                <div class="chat-group-user clearfix">
                  <p class="chat-group-user__name">ユーザーが見つかりません</p>
                </div>
              `
    $("#user-search-result").append(html)
    // console.log(html);
  }

  function  addDeleteUser(user_name,user_id ){
    var html = `
            <div class='chat-group-user'>
              <input name='group[user_ids][]' type='hidden' value='${user_id}'>  
              <p class='chat-group-user__name'>${user_name}</p>
              <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
            </div>
            `
    $(".js-add-user").append(html)
    // console.log(html);
  }

  function addMember(user_id) {
    let html = `<input value="${user_id}" name="group[user_ids][]" type="hidden" id="group_user_ids_${user_id}" />`;
    $(`#${user_id}`).append(html);
    console.log(html);
  }
  // インクリメンタルサーチ
  $("#user-search-field").on("keyup",function(){ // テキストフィールドに文字が入力されるたびにイベントを発火させる
    var input = $("#user-search-field").val();                    // フォームの値を取得するときはval()を使います
    // console.log(input); 取得ok
    var url = $(this).attr("")
    // イベント時に非同期通信で入力したデータを送信
    $.ajax({
      url: "/users",           //users_controllerの、indexアクションにリクエストの送信先を設定する
      type: "GET",               //HTTPメソッド
      data: {keyword: input},    //テキストフィールドに入力された文字を設定する
      dataType: "json"
    })
    .done(function(users){
      // console.log("成功です");
      //emptyメソッドで一度検索結果を空にする
      $("#user-search-result").empty();
      //usersが空かどうかで条件分岐
      if (users.length !== 0) {
        users.forEach(function(user){
          addUser(user);
        });
      } else if (input.length == 0) {    // 返り値がない場合はreturn falseと記述し、返り値がない事を伝える
        return false;
      } else {
          addNoUser();
      }
    })
    .fail(function(){
      // console.log("失敗です");
      alert("ユーザー検索に失敗しました");
    });
  });

  //メンバーの追加、削除
  // 追加ボタンが押された時にイベントが発火するようにする(後から追加された要素に対してのイベント)
  $(document).on("click",".user-search-add",function(){
    // console.log("イベント発火"); ok
  // 追加ボタンをクリックされたユーザーの名前を、チャットメンバーの部分に追加し、検索結果からは消す
    // どのユーザーのhtmlかを特定するためにdata-user-idとdata-user-nameを取得しましょう
    var user_name = $(".user-search-add").data("user-name");
    var user_id = $(".user-search-add").data("user-id");
    $(this).parent().remove();   //クリックした親要素を取得し削除する
    addDeleteUser(user_name,user_id);
    addMember(user_id);
  });
  // 削除を押すと、チャットメンバーから削除される
  $(document).on("click",".user-search-remove",function(){
    $(this).parent().remove();
  // ログイン中のユーザーを追加済みの状態にする →ビューに書く
  // 編集画面では既存のユーザーが追加済みの状態であることを確認する→ビューに書く
  });
});