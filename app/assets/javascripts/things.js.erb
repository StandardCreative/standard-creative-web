var generate_key = function(len){
    var s = '';
    while (s.length < len)
    s += Math.random().toString(36).substr(2, len);
    return s.substr(0, len);
};

var get_file_props = function(file){
    return {
        filekey: generate_key(36),
        filename: file.name,
        content_type: file.type
    };
};

var generate_upload_progress = function(file, props){
    var upload = $("<div/>").addClass("upload").attr("data-filekey", props.filekey);

    upload.append($("<div/>").addClass("filename").text(file.name));
    upload.append($("<div/>").addClass("percent").html("&infin;"));

    return upload;
};

var try_hiding_progress = function(){
    if ($("#progress .uploads .upload").length === $("#progress .uploads .upload[data-complete=true]").length) {
        $("#progress").fadeOut(200, function(){
            $("#progress .uploads").empty();
            window.location.reload();
        });
    }
};

var post_file = function(file, props, opts){
    var s3Data = new FormData();
    s3Data.append("key", "things/" + props.filekey + "/" + props.filename);
    s3Data.append("AWSAccessKeyId", window.AWS_ACCESS_KEY_ID);
    s3Data.append("acl", "public-read");
    s3Data.append("policy", window.THING_S3_POLICY);
    s3Data.append("signature", window.THING_S3_SIGNATURE);
    s3Data.append("Content-Type", props.content_type);
    s3Data.append("file", file);

    var upload_progress = generate_upload_progress(file, props);

    $("#progress").fadeIn(200);
    $("#progress").find(".uploads").append(upload_progress);

    opts = _.defaults(opts, {
        url: "https://" + window.S3_BUCKET + ".s3.amazonaws.com/",
        data: s3Data,
        cache: false,
        contentType: false,
        processData: false,
        type: "POST",
        success: function(){
            upload_progress.find(".percent").text('100%');
        },
        error: function(){
            upload_progress.find(".percent").text('ERROR UPLOADING');
        },
        progress: function(e){
            if (e.lengthComputable) {
                upload_progress.find(".percent").text(Math.round((e.loaded / e.total) * 100) + '%');
            }
        }
    });
    
    return $.ajax(opts);
};

var save_model = function(props, opts){
    var upload_progress = $('.upload[data-filekey="' + props.filekey + '"]');

    upload_progress.find(".percent").text("SAVING...");

    opts = _.defaults(opts, {
        url: page_entity.url ? page_entity.url : "/",
        type: page_entity.url ? "PATCH" : "POST",
        dataType: "json",
        data: {
            thing: props,
        },
        success: function() {
            upload_progress.find(".percent").text("SAVED");
        },
        error: function(){
            upload_progress.find(".percent").text("ERROR SAVING");
        },
        complete: function(){
            upload_progress.attr("data-complete", true);

            setTimeout(function(){
                try_hiding_progress();
            }, 500);
        }
    });
    
    return $.ajax(opts);
};

$(function(){
    $(document).on("dragover", function(e){
        var dt = e.originalEvent.dataTransfer;

        if (dt.types != null) {
            if (dt.types.indexOf ? dt.types.indexOf('Files') === -1 : ! dt.types.contains('application/x-moz-file')) {
                return false;
            }
        }

        $("#droparea").fadeIn(200);
        clearTimeout(window.dropzone_timeout);

        window.dropzone_timeout = setTimeout(function(){
            window.dropzone_timeout = null;
            $("#droparea").fadeOut(200);
        }, 100);
    });

    $(document).on("drop", function(e){
        var files = e.originalEvent.dataTransfer.files;

        if (page_entity.url) {
            files = [files[0]];
        }

        _.each(files, function(file){
            var props = get_file_props(file);

            post_file(file, props, {
                success: function(){
                    save_model(props, {});
                }
            });
        });
    });
});
