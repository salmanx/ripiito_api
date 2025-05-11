class MemberPackagePurchase < ApplicationRecord
  belongs_to :member_package
  belongs_to :member_package_payment
end
