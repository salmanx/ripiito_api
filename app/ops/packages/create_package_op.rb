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
    float   :base_price, default: 0.0
    integer :trial_days, default: 0
    boolean :is_price_visible, default: true
    integer :max_subscriber
    boolean :taxable, default: false
    float   :tax_fee, default: 0.0
    string  :package_type
    string  :pricing_model
    string  :pricing_type
    boolean :exclusive, default: false

    integer :plan_id

    outputs :package

    protected

    def perform
      plan = Plan.find(plan_id)
      attrs = extract_attributes(PACKAGE_ATTRS)

      package = Package.new(attrs.merge(plan: plan))

      if package.valid?
        package.save
        output :package, package
      else
        package.errors.each { |e| errors.add(e.attribute, e.message) }
      end
    end
  end
end
