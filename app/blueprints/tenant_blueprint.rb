# frozen_string_literal: true

class TenantBlueprint < Blueprint
  fields(
    :name,
    :ip,
    :location,
    :lat_lon,
    :url,
  )
end
