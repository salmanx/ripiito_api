# frozen_string_literal: true

class PlanBlueprint < Blueprint
  exclude :id

  # association :tenant, blueprint: TenantBlueprint

  field :slug

  fields(*Attributes::PlanAttributes::PLAN_ATTRS)
end
