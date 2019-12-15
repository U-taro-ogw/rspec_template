module CustomErrors
  class BadRequestError < StandardError; end
  class UnauthorizedError < StandardError; end
  class ForbiddenError < StandardError; end

  class NotFoundError < StandardError
    def http_status
      :not_found
    end
  end
end
