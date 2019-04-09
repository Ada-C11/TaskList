TASKS = [
    {title: 'feed cat'},
    {title: 'make breakfast'},
    {title: 'take vitamins'},
    {title: 'play with cat'},
    {title: 'have a coffee'},
    {title: 'take a walk'}
]

class TasksController < ApplicationController
    def index
        @tasks = TASKS
    end 
end
