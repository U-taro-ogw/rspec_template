module DatetimeHelper
  def to_iso8601(value)
    value.iso8601(3)
  end
end
