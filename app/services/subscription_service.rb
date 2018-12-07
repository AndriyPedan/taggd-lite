class SubscriptionService
  def initialize(user, params)
    @subscription = user.subscription
    @params = params
  end

  def subscribe
    update_tokens
    process_subscription
  end

  private

  def process_subscription
    errors = []
    begin
      create_subscription
    rescue Pin::ChargeError => error
      errors << error.response['error_description']
    end
    errors
  end

  def update_tokens
    if @customer_token
      @customer = Pin::Customer.update(@customer_token,
                                       card_token: @params[:card_token], email: @params[:email])
    else
      @customer = Pin::Customer.create(@params[:email], @params[:card_token])
      @subscription.update(customer_token: @customer['token'])
    end
  end

  def create_subscription
    pin_response = Pin::Subscription.create(plan_token: @subscription.plan_token,
                                            customer_token: @customer['token'],
                                            card_token: @customer['card']['token'])
    @subscription.update(card_token: @customer['card']['token'], subscription_token: pin_response[:token])
  end

  def customer_token
    @customer_token ||= @subscription.customer_token
  end
end
