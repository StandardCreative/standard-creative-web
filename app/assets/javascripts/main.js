$(function(){
    $(document).on("drop dragover", function(e){
        e.preventDefault();
    });

    $("#share_buttons .share_toggle").click(function(e){
        e.preventDefault();
        $(this).hide();
        $("#share_services").show();
    });

    setTimeout(function(){
        $(".flash").each(function(){
            $(this).slideUp(200);
        });
    }, 1500);
});
