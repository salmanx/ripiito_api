# frozen_string_literal: true

class PlansController < ApplicationController
  def show
    plan = Plan.find(params.expect(:id))
    render json: PlanBlueprint.render(plan)
  end

  def create
    op = Plans::CreatePlanOp.submit(plan_params)

    if op.success?
      render json: PlanBlueprint.render(op.plan), status: :created
    else
      render_error_response(op.errors)
    end
  end

  private

  def plan_params
    params.expect(plan: Attributes::PlanAttributes::PLAN_ATTRS + [:tenant_id])
  end
end
