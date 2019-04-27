$(function() {
    $("#only_finalized").click(function(event) {
        if ($(this).prop("checked") &&
            !confirm("You are selecting to download ALL orders, including those which have not been finalized " +
            "(i.e., the user did not actually decide to order gear). Are you sure you want to proceed?")) {
            event.preventDefault();
        }
    });
});