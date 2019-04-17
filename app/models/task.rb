# frozen_string_literal: true

class Task < ApplicationRecord
  def completed
    !completed_at.blank?
  end
end