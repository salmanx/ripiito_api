# frozen_string_literal: true

class TenantBlueprint < Blueprint
  identifier :uuid
  exclude :id

  fields(
    :name,
    :ip,
    :location,
    :lat_lon,
    :url,
  )
end
