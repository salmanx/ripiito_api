# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemberPackagesController, type: :controller do
  let(:member_package) { create(:member_package) }
  let(:package) { create(:package) }
  let(:member) { create(:member) }

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          member_package: {
            package_id: package.id,
            email: member.email,
            purchase_price: 100.00,
            tax_fee: 0.0,
            total_price: 100.00,
            payment_method: 'COD',
          },
        }
      end

      it 'creates a new member_package' do
        expect do
          post :create, params: valid_params
        end.to change(MemberPackage, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          member_package: {
            purchase_price: 100.00,
            tax_fee: 0.0,
            total_price: 100.00,
          },
        }
      end

      it 'returns errors' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:conflict)
        body = JSON.parse(response.body)
        expect(body['errors'].keys).to include(
          'email',
          'payment_method',
          'member',
          'package',
        )
      end
    end
  end
end
