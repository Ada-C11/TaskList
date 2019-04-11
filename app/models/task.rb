class Task < ApplicationRecord
  def completed?
    !completed_at.blank?
  end
end
