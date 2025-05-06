module Enum
  module PackageEnum
    STATUSES = {
      DRAFT: 'DRAFT',
      ACTIVE: 'ACTIVE',
      RETIRED: 'RETIRED',
    }.freeze

    PRICING_TYPE = {
      ONE_TIME: 'ONE_TIME',
      RECURRING: 'RECURRING',
      USAGE: 'USAGE',
    }.freeze

    PACKAGE_TYPE = {
      REQUIRED: 'REQUIRED',
      OPTIONAL: 'OPTIONAL',
      ADDON: 'ADDON',
    }.freeze

    PRODUCT_TYPE = {
      PHYSICAL: 'PHYSICAL',
      SERVICE: 'SERVICE',
      DIGITAL: 'DIGITAL',
    }.freeze

    PRICING_MODEL = {
      FIXED: 'FIXED',
      TIRED: 'TIRED',
      VOLUME: 'VOLUME',
    }

    BILLING_PERIOD_UNITS = {
      DAY: 'DAY',
      WEEK: 'WEEK',
      MONTH: 'MONTH',
      YEAR: 'YEAR',
    }.freeze
  end
end
