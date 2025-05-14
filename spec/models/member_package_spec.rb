# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemberPackage, type: :model do
  subject { build(:member_package) }

  describe 'validations' do
    it { should validate_presence_of(:purchase_price) }
    it { should validate_numericality_of(:purchase_price).is_greater_than_or_equal_to(0) }

    it { should validate_numericality_of(:tax_fee).is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:total_price) }
    it { should validate_numericality_of(:total_price).is_greater_than_or_equal_to(0) }

    it {
      is_expected.to validate_inclusion_of(:payment_method)
        .in_array(Enum::PaymentEnum::PAYMENT_METHODS.values)
    }
  end

  describe 'associations' do
    it { should belong_to(:member) }
    it { should belong_to(:package) }
  end
end
