# frozen_string_literal: true

class MemberPackage < ApplicationRecord
  validates :purchase_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :tax_fee, numericality: { greater_than_or_equal_to: 0 }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :payment_method, presence: true, inclusion: { in: Enum::PaymentEnum::PAYMENT_METHODS.values }
  validate :check_if_member_package_exist, on: :create

  belongs_to :member
  belongs_to :package
  delegate :plan, to: :package

  private

  def check_if_member_package_exist
    return unless MemberPackage.exists?(member_id: member_id, package_id: package_id)

    errors.add(:base, 'already exists')
  end
end
