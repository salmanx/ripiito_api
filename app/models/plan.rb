# frozen_string_literal: true

class Plan < ApplicationRecord
  include SlugGenerator

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :status, presence: true, inclusion: { in: Enum::PlanEnum::STATUSES }
  validates :billing_period, presence: true, numericality: { only_integer: true }
  validates :billing_period_unit, presence: true, inclusion: { in: Enum::PlanEnum::BILLING_PERIOD_UNITS }
  validates :duration, presence: true, numericality: { only_integer: true }
  validates :auto_renewable, inclusion: { in: [true, false] }
  validates :cancelable, inclusion: { in: [true, false] }
  validates :base_price, presence: true, numericality: { greater_than: 0 }
  validates :trial_days, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :is_price_visible, inclusion: { in: [true, false] }, allow_nil: true
  validates :currency, presence: true, inclusion: { in: Enum::PlanEnum::CURRENCY_CODE }
  validates :max_subscriber, numericality: { only_integer: true }, allow_nil: true
  validates :taxable, inclusion: { in: [true, false] }
  validates :tax_fee, numericality: { greater_than: 0 }, presence: true, if: -> { taxable? }
  validate :tax_fee_only_if_taxable

  private

  def tax_fee_only_if_taxable
    return unless taxable && tax_fee.present?

    errors.add(:tax_fee, 'must be blank when taxable is false')
  end
end
