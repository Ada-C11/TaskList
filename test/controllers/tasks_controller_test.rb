require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion_date: "20190410", completed: false
  }

  # Tests for Wave 1
  describe "index" do
    it "can get the index path" do
      # Act
      get tasks_path

      # Assert
      must_respond_with :success
    end

    it "can get the root path" do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  # Unskip these tests for Wave 2
  describe "show" do
    it "can get a valid task" do
    
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do
      

      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      

      # Arrange
      # Note to students:  Your Task model **may** be different and
      #   you may need to modify this.
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completion_date: "20190410"
        },
      }
      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do

      get edit_task_path(task.id)
      must_respond_with :success
    
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
    
      get edit_task_path(-1)
      must_respond_with :redirect

    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      task = Task.create!(name: "original")
      task_data = {
        task: {
          name: "changed",
        },
      }

      # Act
      patch task_path(task), params: task_data

      # Assert
      must_respond_with :redirect
      must_redirect_to task_path(task)

      task.reload
      expect(task.name).must_equal(task_data[:task][:name])

      # Your code here
    end

    it "will redirect to the root page if given an invalid id" do
      task_data = {
        task: {
          name: "changed",
        },
      }
      patch task_path(-1), params: task_data
      must_respond_with :redirect
      # Your code here
    end

    it "will not update if the params are invalid" do
      id = task.id
  
      expect {
        patch task_path(id), params: {}
      }.must_raise ActionController::ParameterMissing

    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    
    
    it "can destroy a task" do
    
    # Arrange
     read = Task.new(name: "read", description: "book", completion_date: "today")

     read.save
     id = read.id
 
     # Act
      expect {
       delete task_path(id)
      }.must_change 'Task.count', -1
 
     read = Task.find_by(name:  "read")
 
     expect(read).must_be_nil
     
     must_respond_with :redirect
     must_redirect_to tasks_path
    end


  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
    it "can mark a incomplete task as complete" do

      read = Task.create!(name: "read", description: "book", completion_date: "today", completed: false)
      id = read.id
      patch complete_task_path(id)
      read = Task.find_by(id: id)
      expect(read.completed).must_equal(true)
      must_respond_with :redirect
      must_redirect_to tasks_path

    end

    it "can mark a complete task as incomplete" do

      shower = Task.create!(name: "shower", description: "book", completion_date: "today", completed: true)
      id = shower.id
      patch complete_task_path(id)
      shower = Task.find_by(id: id)
      expect(shower.completed).must_equal(false)
      must_respond_with :redirect
      must_redirect_to tasks_path

    end

    it "will redirect for an invalid task" do

      id = "invalid"
      patch complete_task_path(id)
      must_respond_with :redirect
      must_redirect_to tasks_path

    end

  end
end