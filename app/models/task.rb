class Task < ApplicationRecord
  def status
    if completion_date
      return "DONE"
    else
      return "TO-DO"
    end
  end

  def toggle
    if completion_date
      return "Unmark Done"
    else
      return "Mark Done"
    end
  end
end
