module SerializerOptions
  extend ActiveSupport::Concern

  def serialize_option(count: 0)
    options = {}
    options[:meta] = { total: count }
    options
  end
end
