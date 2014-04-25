$(function(){
    $(document).on("drop dragover", function(e){
        e.preventDefault();
    });

    setTimeout(function(){
        $(".flash").each(function(){
            $(this).slideUp(200);
        });
    }, 1500);
});
