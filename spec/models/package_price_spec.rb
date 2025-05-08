# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PackagePrice, type: :model do
  subject { build(:package_price) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { is_expected.to allow_value(true, false, nil).for(:is_price_visible) }
  it { is_expected.to allow_value(true, false).for(:taxable) }
  it { is_expected.to allow_value(nil).for(:taxable) }

  context 'when taxable is true, requires tax_fee' do
    subject { build(:package_price, taxable: true) }

    it { is_expected.to validate_presence_of(:tax_fee) }
    it { is_expected.to validate_numericality_of(:tax_fee).is_greater_than(0) }
  end
end
