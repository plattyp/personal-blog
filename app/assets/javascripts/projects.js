$(document).on("ready page:load", function () {

  var $btns = $('a.btn-filter-language-toolbar').on('click',function(e) {

    e.preventDefault();

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
