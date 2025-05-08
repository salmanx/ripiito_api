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
    integer :plan_id

    object :package_price_attributes, null: true do
      decimal :price
      decimal :tax_fee
      boolean :taxable
      boolean :is_price_visible
      date :effective_from
      date :effective_to
    end

    validate :require_package_price_attributes

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
        package.errors.each { |e| errors.add(e.attribute, "#{e.attribute} #{e.message}") }
      end
    end

    private

    def require_package_price_attributes
      return unless package_price_attributes.nil?

      errors.add(:package_price, "can't be blank. It must be an object with price property.")
    end
  end
end
