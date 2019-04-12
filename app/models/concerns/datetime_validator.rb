# frozen_string_literal: true

class DatetimeValidator < ActiveModel::Validator
  def validate(record)
    Time.parse(record.due_date.to_s)
  rescue ArgumentError
    record.errors[:due_date] << "Invalid date format"
  end
end
