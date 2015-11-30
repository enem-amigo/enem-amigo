$(function() {
    $(".answer").prop("disabled", false);
    $(".answer").click(function() {
        $(this).prop("disabled", true);
    })

    $(".clickable-row").click(function() {
        window.document.location = $(this).data("href");
    });

})