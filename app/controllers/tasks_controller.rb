class TasksController < ApplicationController
  TASKS = [
    {todo: "Task List Project", when: "today"},
    {todo: "Groceries", when: "Friday"},
  ]

  def index
    @tasks = TASKS
  end
end
