# frozen_string_literal: true

class PlanBlueprint < Blueprint
  exclude :id

  field :slug

  fields(*Attributes::PlanAttributes::PLAN_ATTRS)
end
