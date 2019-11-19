class ApplicationController < ActionController::API
  include ApiResponse
  include ApiRequestable
  include SerializerOptions
end
