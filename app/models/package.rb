# frozen_string_literal: true

class Package < ApplicationRecord
  include SlugGenerator

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }, uniqueness: { scope: :plan_id }
  validates :status, presence: true, inclusion: { in: Enum::PackageEnum::STATUSES.values }
  validates :billing_period, presence: true, numericality: { only_integer: true }
  validates :billing_period_unit, presence: true, inclusion: { in: Enum::PackageEnum::BILLING_PERIOD_UNITS.values }
  validates :auto_renewable, inclusion: { in: [true, false] }
  validates :cancelable, inclusion: { in: [true, false] }
  validates :base_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :trial_days, numericality: { only_integer: true }, allow_nil: true
  validates :is_price_visible, inclusion: { in: [true, false] }, allow_nil: true
  validates :max_subscriber, numericality: { only_integer: true }, allow_nil: true
  validates :taxable, inclusion: { in: [true, false] }, allow_nil: true
  validates :tax_fee, numericality: { greater_than: 0 }, presence: true, if: -> { taxable? }
  validate :tax_fee_only_if_taxable
  validates :package_type, presence: true, inclusion: { in: Enum::PackageEnum::PACKAGE_TYPE.values }
  validates :pricing_model, presence: true, inclusion: { in: Enum::PackageEnum::PRICING_MODEL.values }
  validates :pricing_type, presence: true, inclusion: { in: Enum::PackageEnum::PRICING_TYPE.values }

  belongs_to :plan

  private

  def tax_fee_only_if_taxable
    return unless taxable && tax_fee.present?

    errors.add(:tax_fee, 'must be blank when taxable is false')
  end
end
