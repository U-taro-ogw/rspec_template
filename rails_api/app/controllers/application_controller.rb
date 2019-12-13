class ApplicationController < ActionController::API
  include ApiResponse
  include ApiRequestable
  include SerializerOptions

  # TODO catchする
  rescue_from StandardError, with: :render_404

  private

  def render_404
    response_not_found
  end
end
