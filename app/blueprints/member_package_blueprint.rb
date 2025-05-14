# frozen_string_literal: true

class MemberPackageBlueprint < Blueprint
  field :member_id

  fields(*Attributes::MemberPackageAttributes::MEMBER_PACKAGE_ATTRS - %i[email])
end
