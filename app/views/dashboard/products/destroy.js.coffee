$("[data-product='<%= params[:id] %>']").slideUp 'normal', ->
  $(this).remove()
