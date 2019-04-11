class Task < ApplicationRecord
  def status
    if completion_date
      return "DONE"
    else
      return "TO-DO"
    end
  end
end
