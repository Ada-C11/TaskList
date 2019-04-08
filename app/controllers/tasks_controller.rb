TASKS = [ "Task One", "Task Two", "Task Three", "Task Four"
]


class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
