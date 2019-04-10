# class Task
#   def initialize(name)
#     @name = name
#     @complete = false
#   end
# end

TASKS = [
  {name: 'Buy Jesse a toy', complete: false},
  {name: 'Percy needs flea pills', complete: true},
  {name: 'Reload chantals coffee card', complete: true}
]

class TasksController < ApplicationController
  def root
    @message = 'Hello world!'
  end

  def show
    @task = Task.find(params['id'])
  end

  def index
    @tasks = Task.all
    #@tasks = TASKS
  end
end
