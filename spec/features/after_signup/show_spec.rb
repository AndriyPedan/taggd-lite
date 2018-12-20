require 'rails_helper'

feature 'After signup page', js: true do
  given!(:user) { create(:user) }

  given!(:plans) do
    [
      { 'name' => 'Complete Annually',
        'amount' => 6000,
        'currency' => 'USD' }
    ]
  end

  before do
    sign_in(user)
    allow(Pin::Plan).to receive(:all) { plans }
  end

  feature 'Business account step' do
    let(:business_accounts) do
      { 'Tagg Tag': {
        username: 'tagg._.tag',
        name: 'Tagg Tag',
        token: 'acount_token',
        business_id: '17841409430992073'
      }.to_json }
    end
    let!(:retailer) { create(:retailer, current: true) }

    before do
      allow_any_instance_of(RetailerService).to receive(:build_retailers) { business_accounts }
      visit('/after_signup/business_account')
    end

    scenario 'select business account' do
      expect(page).to have_content('Business account')
      select 'Tagg Tag', from: 'user[retailer][business_id]'
      user.current_retailer = retailer
      click_button('Next')
      expect(page).to have_content('Subscription plan')
    end
  end

  feature 'Subscription plan step' do
    let!(:retailer) { create(:retailer, user: user, current: true) }

    before do
      visit('/after_signup/subscription_plan')
    end

    scenario 'select subscription plan' do
      expect(page).to have_content('Subscription plan')
      first('.btn').click
      expect(page).to have_content('Card addition')
    end
  end
end
