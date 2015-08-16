$(document).on("page:load", function () {

  var $btns = $('a.btn-filter-language-toolbar').click(function() {

    $btns.removeClass('active');
    $(this).addClass('active');

    var language_id = this.id === "all" ? 0 : this.id;

    $.ajax({
        type: "GET",
        url: '/projects',
        data: {
            language_id: language_id
        },
        dataType: "script",

        success: function () {
        }
    });

  });
  
});
