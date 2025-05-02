# frozen_string_literal: true

require 'ipaddr'

module Tenants
  class CreateTenantOp < Op
    string :name
    # default is required, otherwise IPAddr.new() will throw error if ip not passed
    string :ip, default: ''
    string :location
    # object :lat_lon
    string :url

    outputs :tenant

    protected

    def perform
      validate_url url
      validate_ip ip

      tenant = new_tenant

      if tenant.valid?
        tenant.save
        output :tenant, tenant
      else
        tenant.errors.each { |e| errors.add(e.attribute, e.message) }
      end
    end

    private

    def new_tenant
      Tenant.new(
        name: name,
        ip: ip,
        location: location,
        url: url,
      )
    end

    def validate_url(url)
      errors.add(:url, 'must provide URL') && return if url.blank?

      begin
        uri = URI.parse(url)
        errors.add(:url, 'must be a valid URL') unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      rescue URI::InvalidURIError
        errors.add(:url, 'must be a valid URL')
      end
    end

    def validate_ip(ip)
      errors.add(:ip, 'must provide an ip') && return if ip.blank?

      IPAddr.new(ip)
    rescue IPAddr::InvalidAddressError
      errors.add(:ip, 'must provide a valid ip')
    end

    def validate_lat_lon_cordinates(lat_lon)
      if lat_lon.is_a?(Hash)
        lat = lat_lon[:lat]
        lon = lat_lon[:lon]

        unless lat.is_a?(Numeric) && lat.between?(-90, 90)
          errors.add(:lat_lon, 'lat must be a number between -90 and 90')
        end

        unless lon.is_a?(Numeric) && lon.between?(-180, 180)
          errors.add(:lat_lon, 'lon must be a number between -180 and 180')
        end
      else
        errors.add(:lat_lon, 'must be an object with lat and lon key')
      end
    end
  end
end
