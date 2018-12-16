TaggdLite = TaggdLite || {}

TaggdLite = imageInput: (element) ->
  $element = (element)
  $preview = $('[data-preview]')

  $element.on 'change', ->
    setURL()


  setURL = () ->
    $preview.attr('src', $element.val())

  $ ->
    setURL()

Elemental.addNamespace TaggdLite
