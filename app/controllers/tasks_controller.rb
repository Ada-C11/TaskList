TASKS = [
    "feed cat",
    "make breakfast",
    "take vitamins",
    "play with cat",
    "have a coffee",
    "take a walk",
]

class TasksController < ApplicationController
    def index
        @tasks = TASKS
    end 
end
