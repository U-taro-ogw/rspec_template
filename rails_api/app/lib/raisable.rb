module Raisable
  extend ActiveSupport::Concern
  include CustomErrors

  def raise_not_found
    raise CustomErrors::NotFoundError
  end
end