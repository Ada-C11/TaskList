TASKS = [
  "Set alarm", 
  "Make Breakfast", 
  "Make Lunch", 
  "Make Dinner", 
  "Exercise", 
  "Do Homework",
]

class TasksController < ApplicationController
  def index
    # add an instance variable here
    @tasks = TASKS
  end
end
