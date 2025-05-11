# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plan, type: :model do
  subject { build(:plan) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(100) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_inclusion_of(:status).in_array(Enum::PlanEnum::STATUSES.values) }
    it { is_expected.to validate_presence_of(:duration) }
    it { is_expected.to validate_numericality_of(:duration).only_integer }
    it { is_expected.to allow_value(true, false).for(:auto_renewable) }
    it { is_expected.not_to allow_value(nil).for(:auto_renewable) }
    it { is_expected.to allow_value(true, false).for(:cancelable) }
    it { is_expected.not_to allow_value(nil).for(:cancelable) }
    it { is_expected.to validate_numericality_of(:trial_days).only_integer.allow_nil }
    it { is_expected.to validate_presence_of(:currency) }
    it { is_expected.to validate_inclusion_of(:currency).in_array(Enum::PlanEnum::CURRENCY_CODE.values) }
    it { is_expected.to validate_numericality_of(:max_subscriber).only_integer.allow_nil }
  end

  describe 'associations' do
    it { should belong_to(:tenant) }
    it { should have_many(:packages).dependent(:destroy) }
  end
end
