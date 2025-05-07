# frozen_string_literal: true

class PackagesController < ApplicationController
  def show
    package = Package.find(params.expect(:id))
    render json: PackageBlueprint.render(package), status: :ok
  end

  def create
    op = Packages::CreatePackageOp.submit(package_params)

    if op.success?
      render json: PackageBlueprint.render(op.package), status: :created
    else
      render_error_response(op.errors)
    end
  end

  private

  def package_params
    params.expect(package: Attributes::PackageAttributes::PACKAGE_ATTRS + [:plan_id])
  end
end
