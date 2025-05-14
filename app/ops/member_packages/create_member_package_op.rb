# frozen_string_literal: true

module MemberPackages
  class CreateMemberPackageOp < Op
    include Attributes::MemberPackageAttributes

    string  :email
    string  :package_id
    decimal :purchase_price
    decimal :tax_fee
    decimal :total_price
    string  :payment_method

    outputs :member_package

    protected

    def perform
      validate_email email

      member = Member.find_by(email: email)

      attrs = extract_attributes(MEMBER_PACKAGE_ATTRS).except(:email)

      member_package = MemberPackage.new(
        attrs.merge(member: member),
      )

      if member_package.valid?
        member_package.save
        output :member_package, member_package
      else
        member_package.errors.each { |e| errors.add(e.attribute, e.message) }
      end
    end

    private

    def validate_email(email)
      return if email.present?

      errors.add(:email, "can't be blank!")
    end
  end
end
