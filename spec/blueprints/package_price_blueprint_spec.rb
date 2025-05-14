# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PackagePriceBlueprint do
  let(:package_price) { create(:package_price) }
  let(:blueprint) { PackagePriceBlueprint.render(package_price) }
  let(:parsed) { JSON.parse(blueprint) }

  it 'includes the correct fields' do
    expect(parsed).to include(
      'id',
      'effective_from',
      'effective_to',
      'is_price_visible',
      'price',
      'tax_fee',
      'taxable',
      'created_at',
      'updated_at',
    )
  end
end
