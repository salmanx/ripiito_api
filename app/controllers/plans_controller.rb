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
      render_error_response(op.errors, 409)
    end
  end

  private

  def plan_params
    params.expect(
      plan: %i[
        name
        status
        billing_period
        billing_period_unit
        duration
        auto_renewable
        cancelable
        base_price
        trial_days
        is_price_visible
        currency
        max_subscriber
        taxable
        tax_fee
        tenant_id
      ],
    )
  end
end
