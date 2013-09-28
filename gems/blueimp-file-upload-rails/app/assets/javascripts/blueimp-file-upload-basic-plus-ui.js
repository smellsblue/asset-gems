//= require jquery.ui.widget
//= require blueimp-templates
//= require blueimp-load-image
//= require blueimp-canvas-to-blob
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require jquery.fileupload-process
//= require jquery.fileupload-image
//= require jquery.fileupload-audio
//= require jquery.fileupload-video
//= require jquery.fileupload-validate
//= require jquery.fileupload-ui

$(document).on("ready page:load", function() {
    $(".fileupload").each(function() {
        var fileupload = this;
        var $fileupload = $(this);
        var url = $fileupload.data("url");

        if (!url || $.trim(url) == "") {
            url = $fileupload.attr("action");
        }

        $fileupload.fileupload({ url: url });

        // Load existing files:
        $fileupload.addClass("fileupload-processing");
        $.ajax({
            url: $fileupload.fileupload("option", "url"),
            dataType: "json",
            context: fileupload
        }).always(function () {
            $(this).removeClass("fileupload-processing");
        }).done(function (result) {
            $(this).fileupload("option", "done")
                .call(this, null, {result: result});
        });

        // Show the blueimp Gallery as lightbox when clicking on image links:
        $(".files", fileupload).on("click", ".gallery", function (event) {
            // The :even filter removes duplicate links (thumbnail and file name links):
            if (blueimp.Gallery($(".gallery", fileupload).filter(":even"), {
                    index: this
                })) {
                // Prevent the default link action on
                // successful Gallery initialization:
                event.preventDefault();
            }
        });
    });
});
