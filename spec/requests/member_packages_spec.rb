# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MemberPackages API', type: :request do
  #   let(:member_package) { create(:member_package) }
  let(:package) { create(:package) }
  let(:member) { create(:member) }

  let(:valid_attributes) do
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

  let(:invalid_attributes) do
    {
      member_package: {
        purchase_price: 100.00,
        tax_fee: 0.0,
        total_price: 100.00,
      },
    }
  end

  describe 'POST /member_packages' do
    context 'with valid params' do
      it 'creates a package' do
        expect do
          post member_packages_path, params: valid_attributes
        end.to change(MemberPackage, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns errors' do
        post member_packages_path, params: invalid_attributes

        expect(response).to have_http_status(:conflict)

        expect(json_response['errors']).to include(
          'email',
          'payment_method',
          'member',
          'package',
        )
      end
    end
  end
end
