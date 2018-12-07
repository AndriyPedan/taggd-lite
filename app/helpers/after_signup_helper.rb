module AfterSignupHelper
  def price(plan)
    "#{plan['amount'].to_i / 100}#{plan['currency']}"
  end
end
