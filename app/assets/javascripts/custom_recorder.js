function restore(){
    $("#record, #live").removeClass("disabled");
    $(".one").addClass("disabled");
    Fr.voice.stop();
}
$(document).ready(function(){
    $(document).on("click", "#record:not(.disabled)", function(){
        elem = $(this);
        Fr.voice.record($("#live").is(":checked"), function(){
            elem.addClass("disabled");
            $("#live").addClass("disabled");
            $(".one").removeClass("disabled");
        });
    });

    $(document).on("click", "#stop:not(.disabled)", function(){
        restore();
    });

    $(document).on("click", "#play:not(.disabled)", function(){
        Fr.voice.export(function(url){
            $("#audio").attr("src", url);
            $("#audio")[0].play();
        }, "URL");
        restore();
    });

    $(document).on("click", "#download:not(.disabled)", function(){
        Fr.voice.export(function(url){
            $("<a href='"+url+"' download='MyRecording.wav'></a>")[0].click();
        }, "URL");
        restore();
    });

    $(document).on("click", "#base64:not(.disabled)", function(){
        Fr.voice.export(function(url){
            console.log("Here is the base64 URL : " + url);
            alert("Check the web console for the URL");

            $("<a href='"+ url +"' target='_blank'></a>")[0].click();
        }, "base64");
        restore();
    });

    $(document).on("click", "#mp3:not(.disabled)", function(){
        Fr.voice.export(function(base64){
            var meeting_id = $("#meeting_id").val();
            var data = new FormData();
            data.append('file', base64);
            data.append('authenticity_token', $('[name="csrf-token"]')[0].content)
            data.append('meeting_id', meeting_id);
            $.ajax({
                url: "/meetings/process_audio",
                type: 'POST',
                data: data,
                contentType: false,
                processData: false,
                success: function(data) {
                    $('#meeting-content').html(data.message)
                }
            });
        }, "base64");
        restore();
    });




});