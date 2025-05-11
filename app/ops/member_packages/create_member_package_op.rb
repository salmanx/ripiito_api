# frozen_string_literal: true

module MemberPackages
  class CreateMemberPackageOp < Op
    include Attributes::MemberPackageAttributes

    string  :email
    string  :package_slug
    decimal :purchase_price
    decimal :tax_fee
    decimal :total_price
    string  :payment_method

    outputs :member_package

    protected

    def perform
      validate_email email
      validate_package_slug package_slug

      member = Member.find_by(email: email)
      package = Package.find_by(slug: package_slug)

      attrs = extract_attributes(MEMBER_PACKAGE_ATTRS).except(:email, :package_slug)

      member_package = MemberPackage.new(
        attrs.merge(member: member, package: package),
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

    def validate_package_slug(slug)
      return if slug.present?

      errors.add(:package_slug, "can't be blank")
    end
  end
end
