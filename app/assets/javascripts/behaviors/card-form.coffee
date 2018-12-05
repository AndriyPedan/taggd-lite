TaggdLite = TaggdLite || {}

TaggdLite = cardForm: (element) ->
  $element = $(element)
  key = $element.data().apiKey

  $ ->
  pinApi = new (Pin.Api)(key, 'test')
  form = $('form.pin')
  submitButton = form.find(':submit')
  errorContainer = form.find('.errors')
  errorList = errorContainer.find('ul')
  errorHeading = errorContainer.find('h3')

  handleSuccess = (card) ->
    # $('<input>')
    #   .attr({type: 'hidden', name: 'card_token'})
    #   .val(card.token)
    #   .appendTo(form);
    form.get(0).submit()

  handleError = (response) ->
    errorHeading.text response.error_description
    if response.messages
      $.each response.messages, (index, paramError) ->
        $('<li>').text(paramError.param + ': ' + paramError.message).appendTo errorList
    errorContainer.show()
    # Re-enable the submit button
    submitButton.removeAttr 'disabled'

  form.submit (e) ->
    e.preventDefault()
    errorList.empty()
    errorHeading.empty()
    errorContainer.hide()
    submitButton.attr disabled: true

    card =
      number: $('#cc-number').val()
      name: $('#cc-name').val()
      expiry_month: $('#cc-expiry-month').val()
      expiry_year: $('#cc-expiry-year').val()
      cvc: $('#cc-cvc').val()
      address_line1: $('#address-line1').val()
      address_line2: $('#address-line2').val()
      address_city: $('#address-city').val()
      address_state: $('#address-state').val()
      address_postcode: $('#address-postcode').val()
      address_country: $('#address-country').val()

    pinApi.createCardToken(card).then(handleSuccess, handleError).done()

Elemental.addNamespace TaggdLite