# frozen_string_literal: true

module Plans
  class CreatePlanOp < Op
    include Attributes::PlanAttributes

    string  :name
    string  :status, default: Enum::PlanEnum::STATUSES[:DRAFT]
    integer :duration
    boolean :auto_renewable, default: false
    boolean :cancelable, default: true
    integer :trial_days, default: 0
    string  :currency, default: Enum::PlanEnum::CURRENCY_CODE[:JPY]
    integer :max_subscriber
    boolean :exclusive, default: false

    string :tenant_id

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
