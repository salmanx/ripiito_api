# frozen_string_literal: true

class MemberPackageBlueprint < Blueprint
  exclude :id

  field :member_id
  field :package_id

  fields(*Attributes::MemberPackageAttributes::MEMBER_PACKAGE_ATTRS - %i[email package_slug])
end
