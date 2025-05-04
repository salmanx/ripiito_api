# frozen_string_literal: true

module Plans
  class CreatePlanOp < Op
    include Attributes::PlanAttributes

    string  :name
    string  :status, default: Enum::PlanEnum::STATUSES[:DRAFT]
    string  :billing_period
    string  :billing_period_unit
    integer :billing_period
    integer :duration
    boolean :auto_renewable, default: false
    boolean :cancelable, default: true
    float   :base_price, default: 0.0
    integer :trial_days
    boolean :is_price_visible, default: true
    string  :currency, default: Enum::PlanEnum::CURRENCY_CODE[:JPY]
    integer :max_subscriber
    boolean :taxable, default: false
    float   :tax_fee, default: 0.0
    integer :tenant_id

    outputs :plan

    protected

    def perform
      tenant = Tenant.find(tenant_id)
      attrs = extract_attributes(PLAN_ATTRS)

      plan = Plan.new(attrs.merge(tenant: tenant))

      if plan.valid?
        plan.save
        output :plan, plan
      else
        plan.errors.each { |e| errors.add(e.attribute, e.message) }
      end
    end
  end
end
