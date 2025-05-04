# frozen_string_literal: true

class TenantsController < ApplicationController
  def show
    @tenant = Tenant.find(params.expect(:id))
    render json: @tenant
  end

  def create
    op = Tenants::CreateTenantOp.submit(tenant_params)

    if op.success?
      render json: TenantBlueprint.render(op.tenant), status: :created
    else
      render_error_response(op.errors, 409)
    end
  end

  private

  def tenant_params
    params.expect(tenant: %i[name ip location lat_lon url])
  end
end
