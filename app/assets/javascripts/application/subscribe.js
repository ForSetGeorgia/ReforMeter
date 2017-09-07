function setupSubscribe() {
  var $email = $("#subscribe_form_email")
  var $msg = $("#subscribe_message")
  $('#subscribe_form_submit').on('click', function(e) {
    var email = $email.val()
    if(email.match(/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/)) {
      $email.removeClass('invalid')
      $.ajax({
        url: gon.subscribe_url,
        method: "POST",
        dataType: 'json',
        data: {email: email},
        complete: function (msg, status) {
          if(status === "success") {
            var d = msg.responseJSON
            if(d.success) {
              $(".subscribeForm").html("<span class='subscribeMessageSuccess'>" + d.msg + "</span>")
            } else {
              subscribeResponse(d.msg)
            }
          }
          else {
            subscribeResponse(gon.messages.upsss)
          }
        }
     })
    } else {
      subscribeResponse(gon.messages.enter_valid_email)
    }
  });

  function subscribeResponse(msg) {
    $email.addClass('invalid')
    $msg.text(msg)
  }
}


//
