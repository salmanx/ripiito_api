# frozen_string_literal: true

class TenantBlueprint < Blueprint
  identifier :uuid
  exclude :id

  fields(
    :name,
    :slug,
    :ip,
    :location,
    :lat_lon,
    :url,
  )
end
