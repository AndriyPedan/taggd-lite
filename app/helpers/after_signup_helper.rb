module AfterSignupHelper
  def price(plan)
    "#{plan['amount'].to_i / 100}#{plan['currency']}"
  end

  def plan_params(plan)
    { user: { current_retailer_attributes: { id: current_user.current_retailer.id,
                                             subscription_attributes: { plan_token: plan['token'],
                                                                        plan_type: plan['name'].split.first.downcase } } } }
  end
end
