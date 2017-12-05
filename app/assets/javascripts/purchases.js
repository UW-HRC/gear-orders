$(document).ready(function() {
    $("#purchase_item_size_id").change(function(e) {
        var id = $(e.currentTarget).val();

        $("#item_description").text("");

        $.get('/item_sizes/' + id, function(data) {
            $("#item_description").text(data['item_description']);
        });
    });
});
