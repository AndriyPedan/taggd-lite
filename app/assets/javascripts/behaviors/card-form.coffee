TaggdLite = TaggdLite || {}

TaggdLite = cardForm: (element) ->
  $element = $(element)
  key = $element.data().apiKey

  $ ->
    pinApi = new (Pin.Api)(key, 'test')
    submitButton = $element.find(':submit')
    errorContainer = $element.find('.errors')
    errorList = errorContainer.find('ul')
    errorHeading = errorContainer.find('h3')

    handleSuccess = (card) ->
      $.ajax({
        method: 'POST',
        url: '/subscriptions'
        data: { email: $('#email').val(), card_token: card.token },
        success: (response) ->
          errors = response.errors
          if (errors.length > 0)
            $.each errors, (index, error) ->
              $('<li>').text(error).appendTo errorList
            errorContainer.show()
            submitButton.removeAttr 'disabled'
          else
            window.location.href = response.url
      })

    handleError = (response) ->
      errorHeading.text response.error_description
      if response.messages
        $.each response.messages, (index, paramError) ->
          $('<li>').text(paramError.param + ': ' + paramError.message).appendTo errorList
      errorContainer.show()
      submitButton.removeAttr 'disabled'

    $element.submit (e) ->
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
