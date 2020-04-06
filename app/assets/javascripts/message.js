$(function(){
  function buildHTML(message){
    // 「もしメッセージに画像が含まれていたら」という条件式
    if (message.image) {               //data-idが反映されるようにしている
      var html = `<div class="message" data-message-id=${message.id}>
                    <div class="main-chat__message-list__message">
                      <div class="main-chat__message-list__message__upper-info">
                        <p class="main-chat__message-list__message__upper-info__talker">
                        ${message.user_name}
                        </p>
                        <p class="main-chat__message-list__message__upper-info__date">
                        ${message.created_at}
                        </p>
                      </div>
                      <div class="main-chat__message-list__message__lower-info">
                        <p class="main-chat__message-list__message__text">
                        ${message.body}
                        </p>
                        <img class="lower-info__image" src="${message.image}" alt="Dog 4608266  480">
                      </div>
                    </div>
                  </div>`
      return html;
    } else {                              //data-idが反映されるようにしている
      var html = `<div class="message" data-message-id=${message.id}>
                    <div class="main-chat__message-list__message">
                      <div class="main-chat__message-list__message__upper-info">
                        <p class="main-chat__message-list__message__upper-info__talker">
                        ${message.user_name}
                        </p>
                        <p class="main-chat__message-list__message__upper-info__date">
                        ${message.created_at}
                        </p>
                      </div>
                      <div class="main-chat__message-list__message__lower-info">
                        <p class="main-chat__message-list__message__text">
                        ${message.body}
                        </p>
                      </div>
                    </div>
                  </div>`
      return html;
    };
    
  }

  $("#new_message").on ("submit", function(e){  // フォームから非同期通信のリクエストを行うためにフォームにイベントをセットしましょう。
    e.preventDefault();                         // 非同期通信を行うためにデフォルトのフォームを送信する通信により画面遷移してしまうのを防ぐ。
    // console.log("hoge");
    var formData = new FormData(this);          // onメソッドの内部では、$(this)と書くことでonメソッドを利用しているノードのオブジェクトが参照されます。つまり、今回の場合はform要素自体ということになります。
    var url = $(this).attr("action");           // 今回リクエストを送りたいパスはフォームのaction属性に格納されている
    $.ajax({
      url: url,                                 //取得したURL 同期通信でいう『パス』
      type: "post",                             //同期通信でいう『HTTPメソッド』.
      data: formData,
      dataType: "json",
      processData: false,                       //
      contentType: false
    })
    .done(function(message){
      // console.log(message);
        var html = buildHTML(message); 
        $(".main-chat__message-list").append(html);
        $('.main-chat__message-list').animate({ scrollTop: $('.main-chat__message-list')[0].scrollHeight});
        $(".new_message")[0].reset();
        $(".submit-btn").prop("disabled", false);
    })
    .fail(function(){
      alert("メッセージ送信に失敗しました");
    });
  });
  // 自動更新
  var reloadMessages = function(){
    
    // カスタムデータ属性を利用し,今表示されている最新メッセージのidを取得する
    var last_message_id = $(".message:last").data("message-id");   // 同じHTML要素(今回はmesssageクラス)の中から一番最後の要素だけを取得したい
    //最新のメッセージのidをリクエストとして送る
    $.ajax({        //ajax関数のurlに何も指定しなかった場合、リクエストのURLは現在ブラウザに表示されているパスと同様になる
      url: "api/messages",              //ルーティングで設定した通り/groups/id番号/api/messagesとなるよう文字列を書く
      type: "get",                      //ルーティングで設定した通りhttpメソッドをgetに指定
      data: {id: last_message_id},      //dataオプションでリクエストに値を含める
      dataType: "json"
    })
    .done(function(messages){
      console.log(messages);
      if (messages.length !== 0) {
        //追加するHTMLの入れ物を作る
        var insertHTML = '';
        //配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
        $.each(messages, function(i, message) {    // $.each( collection, callback(index, value) ) collectionには繰り返し処理を行う配列やオブジェクトを指定.indexにはインデックス番号やkey,valueには繰り返し処理中の値が入る
          insertHTML += buildHTML(message)
        });
        //メッセージが入ったHTMLに、入れ物ごと追加
        $('.main-chat__message-list').append(insertHTML);
        $('.main-chat__message-list').animate({ scrollTop: $('.main-chat__message-list')[0].scrollHeight});
      }
    })
    .fail(function(){
      alert("error");
    });
  };  
  // 自動更新が必要ない画面では行わないようにする(自動更新を行うべきURLである場合のみという条件分岐をする)
  if (document.location.href.match(/\/groups\/\d+\/messages/)) {
    //自動更新を7秒ごとに繰り返す
    setInterval(reloadMessages,7000 );    // 一定時間が経過するごとに処理を実行することができる関数.第一引数に動かしたい関数名を、第二引数に動かす間隔をミリ秒単位で渡す
  }
});