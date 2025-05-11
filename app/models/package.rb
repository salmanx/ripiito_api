# frozen_string_literal: true

class Package < ApplicationRecord
  include SlugGenerator

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :slug, uniqueness: { scope: :plan_id }
  validates :status, presence: true, inclusion: { in: Enum::PackageEnum::STATUSES.values }
  validates :billing_period, presence: true, numericality: { only_integer: true }
  validates :billing_period_unit, presence: true, inclusion: { in: Enum::PackageEnum::BILLING_PERIOD_UNITS.values }
  validates :auto_renewable, inclusion: { in: [true, false] }
  validates :cancelable, inclusion: { in: [true, false] }
  validates :trial_days, numericality: { only_integer: true }, allow_nil: true
  validates :package_type, presence: true, inclusion: { in: Enum::PackageEnum::PACKAGE_TYPE.values }
  validates :pricing_model, presence: true, inclusion: { in: Enum::PackageEnum::PRICING_MODEL.values }
  validates :pricing_type, presence: true, inclusion: { in: Enum::PackageEnum::PRICING_TYPE.values }

  belongs_to :plan
  # delegate :tenant, to: :plan
  has_one :package_price, dependent: :destroy
  accepts_nested_attributes_for :package_price
end
