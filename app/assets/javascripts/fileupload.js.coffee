$ ->
  $('.fileupload').fileupload
    dataType: 'json',
    context: '<div class="attachment"></div>',
    add: (e, data) ->
      console.log data
      data.context = $('<div class="attachment"/>').append( '<span class="filename">' +  data.files[0].name + '</span><div class="progress"><div class="bar"></div></div> ').appendTo('.attachments')
      data.submit()
      return

    progress: (e, data) ->
      progress = parseInt(data.loaded / data.total * 100, 10)

      $(data.context).find('.progress .bar').css(
          'width',
          progress + '%'
      )

    done: (e, data) ->
      console.log "done"
      console.log data
      res = data.result
      data.context.replaceWith('<div class="attachment" id="attachment_' + res.id + '"><a class="filename" href="' + res.stuff_url + '">' +  res.stuff_file_name + '<small>' +  '</small></a> <a class="destroy_attachment" href="' + res.stuff_url + '" data-method="delete" data-remote="true" ><small><em>Удалить</em></small></a><input type="hidden" name="' + res.for_model + '[attachment_ids][]" value="' + res.id + '" /></div>')
      return

