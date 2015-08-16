$(document).on("page:load", function () {

  $('a.load-more').click(function (e) {

      e.preventDefault();

      $('.load-more').hide();

      $('.loading-gif').show();

      var last_id = $('.post').last().attr('data-id');

      $.ajax({
          type: "GET",
          url: '/posts',
          data: {
              id: last_id
          },
          dataType: "script",

          success: function () {
              $('.loading-gif').hide();
              $('.load-more').show();
          }
      });

  });

});