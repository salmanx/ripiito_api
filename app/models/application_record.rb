# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # private

  # def gen_random_uuid
  #   self.uuid = Random.uuid_v7
  # end
end
