# frozen_string_literal: true

module SlugGenerator
  extend ActiveSupport::Concern

  included do
    before_validation :generate_slug
    after_validation :remap_slug_errors
  end

  def generate_slug
    self.slug ||= name.parameterize if name.present?
  end

  private

  # slug is generated from name and applied uniq index in database
  # as we are accepting name from client, we will show name is not uniq if slug is not uniq
  def remap_slug_errors
    return if errors[:slug].blank?

    errors[:slug].each do |msg|
      errors.add(:name, msg)
    end
    errors.delete(:slug)
  end
end
