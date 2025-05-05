# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorHandler
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
end
