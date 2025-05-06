# frozen_string_literal: true

class Plan < ApplicationRecord
  include SlugGenerator

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }, uniqueness: { scope: :tenant_id }
  validates :status, presence: true, inclusion: { in: Enum::PlanEnum::STATUSES.values }
  validates :duration, presence: true, numericality: { only_integer: true }
  validates :auto_renewable, inclusion: { in: [true, false] }
  validates :cancelable, inclusion: { in: [true, false] }
  validates :trial_days, numericality: { only_integer: true }, allow_nil: true
  validates :currency, presence: true, inclusion: { in: Enum::PlanEnum::CURRENCY_CODE.values }
  validates :max_subscriber, numericality: { only_integer: true }, allow_nil: true

  belongs_to :tenant
end
