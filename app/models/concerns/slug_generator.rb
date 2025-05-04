# frozen_string_literal: true

module SlugGenerator
  extend ActiveSupport::Concern

  included do
    before_validation :generate_slug
  end

  def generate_slug
    self.slug ||= name.parameterize if name.present?
  end
end
