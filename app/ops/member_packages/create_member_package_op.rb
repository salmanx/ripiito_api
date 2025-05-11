module MemberPackage
  class CreateMemberPackageOp < Op
    string :email
    string :package_slug
    decimal :purchase_price
    decimal :tax_fee
    decimal :total_price
    string :payment_method

    outputs :member_package

    protected

    def perform
      member = Member.find_by(email: email)
      package = Package.find_by(slug: package_slug)

      member_package = MemberPackage.new(
        member: member,
        package: package,
        payment_method: payment_method,
        purchase_price: purchase_price,
        tax_fee: tax_fee,
        total_price: total_price,
        active: false,
      )

      if member_package.valid?
        member_package.save
        output :member_package, member_package
      else
        member_package.errors.each { |e| errors.add(e.attribute, e.message) }
      end
    end
  end
end
