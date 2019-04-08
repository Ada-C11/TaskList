class TasksController < ApplicationController
  def index
    @tasks = [{ name: "watch movie", description: "Hidden Figures", due_date: "Wednesday"},
      {name: "read book", description: "Kindred", due_date: "Friday"},
      { name: "homework", description: "api project", due_date: "Monday"}]
  end
end
