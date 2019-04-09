TASKS = ['Finish the website', 'clean the house', 'sleep'].freeze
class TasksController < ApplicationController
  def index
    @tasks = TASKS
  end
end
