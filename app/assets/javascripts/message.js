$(function(){
  function buildHTML(message){
    // 「もしメッセージに画像が含まれていたら」という条件式
    if (message.image) {
      var html = `<div class="main-chat__message-list__message">
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
                  </div>`
    } else {
      var html = `<div class="main-chat__message-list__message">
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
                  </div>`
    }
    return html;
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
      console.log(message);
        var html = buildHTML(message); 
        $(".main-chat__message-list").append(html);
        $('.main-chat__message-list').animate({ scrollTop: $('.main-chat__message-list')[0].scrollHeight});
        $(".new_message")[0].reset();
        $(".submit-btn").prop("disabled", false);
    })
    .fail(function(){
      alert("メッセージ送信に失敗しました");
    }) 
  })
});