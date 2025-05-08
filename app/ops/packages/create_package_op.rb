# frozen_string_literal: true

module Packages
  class CreatePackageOp < Op
    include Attributes::PackageAttributes

    string  :name
    string  :status, default: Enum::PackageEnum::STATUSES[:DRAFT]
    string  :billing_period_unit
    integer :billing_period
    boolean :auto_renewable, default: false
    boolean :cancelable, default: true
    integer :trial_days, default: 0
    integer :max_subscriber
    string  :package_type
    string  :pricing_model
    string  :pricing_type
    boolean :exclusive, default: false

    object :package_price_attributes do
      decimal :price
      decimal :tax_fee
      boolean :taxable
      boolean :is_price_visible
      date :effective_from
      date :effective_to
    end

    integer :plan_id

    outputs :package

    protected

    def perform
      attrs = extract_attributes(PACKAGE_ATTRS)

      package = Package.new(
        attrs.merge(
          plan_id: plan_id,
          package_price_attributes: package_price_attributes,
        ),
      )

      if package.valid?
        package.save
        output :package, package
      else
        package.errors.each { |e| errors.add(e.attribute, e.message) }
      end
    end
  end
end
