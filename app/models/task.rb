class Task < ApplicationRecord
  def complete
    update(completed: true)
  end

  def incomplete
    update(completed: false)
  end
end
