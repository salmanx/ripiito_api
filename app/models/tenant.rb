# frozen_string_literal: true

class Tenant < ApplicationRecord
  include SlugGenerator

  validates :name, presence: true, length: { minimum: 2, maximum: 40 }, uniqueness: true
  validates :ip, length: { minimum: 12, maximum: 40 }, allow_nil: true
  validates :location, length: { minimum: 3, maximum: 250 }, allow_nil: true
  validates :url, presence: true, length: { minimum: 12, maximum: 60 }, uniqueness: true
end
