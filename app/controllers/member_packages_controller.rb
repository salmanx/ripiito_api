# frozen_string_literal: true

class MemberPackagesController < ApplicationController
  def create
    op = MemberPackages::CreateMemberPackageOp.submit(member_package_params)

    if op.success?
      puts op.inspect

      render json: MemberPackageBlueprint.render(op.member_package), status: :created
    else
      render_error_response(op.errors)
    end
  end

  private

  def member_package_params
    params.require(:member_package).permit(
      Attributes::MemberPackageAttributes::MEMBER_PACKAGE_ATTRS,
    )
  end
end
