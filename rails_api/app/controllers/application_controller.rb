class ApplicationController < ActionController::API
  include ApiResponse
  include ApiRequestable
  include SerializerOptions

  rescue_from CustomErrors::NotFoundError, with: :render_404

  private

  def render_404
    response_not_found
  end
end
