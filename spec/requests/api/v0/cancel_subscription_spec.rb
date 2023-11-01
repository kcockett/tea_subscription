require 'rails_helper'

RSpec.describe 'Cancel Subscription', type: :request do
  describe 'with valid params' do
    it 'cancels a subscription' do
      customer = create(:customer)
      tea = Tea.all.first
      subscription = Subscription.create!(title: "Monthly English Breakfast", price: 7.95, customer_id: customer.id, tea_id: tea.id, status: "active", frequency_months: 1)
      valid_params = { subscription: { status: "cancel"}}

      patch "/api/v0/customers/#{customer.id}/subscriptions/#{subscription.id}", params: valid_params

      expect(response).to have_http_status(:ok)
      
      updated_subscription = Subscription.find(subscription.id)
      expect(updated_subscription.status).to eq("cancelled")
    end
  end

  describe "without valid params" do
    # Future sad path tests
  end
end