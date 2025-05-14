# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemberPackageBlueprint do
  let(:member_package) { create(:member_package) }
  let(:blueprint) { MemberPackageBlueprint.render(member_package) }
  let(:parsed) { JSON.parse(blueprint) }

  it 'includes the correct fields' do
    expect(parsed).to include(
      'id',
      'member_id',
      'package_id',
      'payment_method',
      'purchase_price',
      'tax_fee',
      'total_price',
      'created_at',
      'updated_at',
    )
  end
end
