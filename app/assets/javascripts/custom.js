$(document).ready(function() {
    $(".profile-sidebar").height($(".main-content").height());
});
=======
$(function() {
    $(".answer").prop("disabled", false);
    $(".answer").click(function() {
        $(this).prop("disabled", true);
    })
})