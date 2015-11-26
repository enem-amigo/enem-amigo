$(function() {
    $(".answer").prop("disabled", false);
    $(".answer").click(function() {
        $(this).prop("disabled", true);
    })
})