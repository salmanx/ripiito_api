# frozen_string_literal: true

class CreatePackageEnums < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE TYPE package_status AS ENUM ('DRAFT', 'ACTIVE', 'RETIRED');
      CREATE TYPE pricing_type AS ENUM ('ONE_TIME', 'RECURRING', 'USAGE');
      CREATE TYPE package_type AS ENUM ('REQUIRED', 'OPTIONAL', 'ADDON');
      CREATE TYPE product_type AS ENUM ('PHYSICAL', 'SERVICE', 'DIGITAL');
      CREATE TYPE pricing_model AS ENUM('FIXED', 'TIRED', 'VOLUME');
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE pricing_model;
      DROP TYPE product_type;
      DROP TYPE package_type;
      DROP TYPE pricing_type;
      DROP TYPE package_status;
    SQL
  end
end
