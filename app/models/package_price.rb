# frozen_string_literal: true

class PackagePrice < ApplicationRecord
  before_validation { self.effective_from ||= Time.current }

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :is_price_visible, inclusion: { in: [true, false] }, allow_nil: true
  validates :taxable, inclusion: { in: [true, false] }, allow_nil: true
  validates :tax_fee, numericality: { greater_than: 0 }, presence: true, if: -> { taxable? }
  validate  :tax_fee_only_if_taxable

  belongs_to :package

  private

  def tax_fee_only_if_taxable
    return unless taxable && tax_fee.present?

    errors.add(:tax_fee, 'must be blank when taxable is false')
  end
end
