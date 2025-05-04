# frozen_string_literal: true

class Tenant < ApplicationRecord
  before_validation :generate_slug, on: :create

  validates :name, presence: true, length: { minimum: 2, maximum: 40 }, uniqueness: true
  validates :ip, presence: true, length: { minimum: 12, maximum: 40 }, allow_nil: true
  validates :location, length: { minimum: 3, maximum: 250 }, allow_nil: true
  validates :url, presence: true, length: { minimum: 12, maximum: 40 }, uniqueness: true

  private

  def generate_slug
    self.slug ||= name.parameterize if name.present?
  end
end
