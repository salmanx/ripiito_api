# frozen_string_literal: true

class Member < ApplicationRecord
  belongs_to :tenant
end
