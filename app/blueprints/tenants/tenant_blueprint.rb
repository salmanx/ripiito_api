# frozen_string_literal: true

module Tenants
  class TenantBlueprint < Blueprint
    identifier :id
    fields(
      :name,
      :slug,
      :ip,
      :location,
      :lat_lon,
      :url,
      :created_at,
    )
  end
end
