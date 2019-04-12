require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create task_name: "sample task", description: "this is an example for a test",
                completed: false
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
      # skip
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will redirect for an invalid task" do
      # skip
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do
      # skip

      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new task" do
      # skip

      # Arrange
      # Note to students:  Your Task model **may** be different and
      #   you may need to modify this.
      task_hash = {
        task: {
          task_name: "new task",
          description: "new task description",
          completed: false,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(task_name: task_hash[:task][:task_name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completed).must_equal task_hash[:task][:completed]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do

      # Arrange
      # above

      # Act
      get edit_task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      # Arrange
      id = -1
      # Act
      get edit_task_path(id) # double check this is the path I want to use

      # Assert
      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      #Arrange #Create a task
      task_hash = {
        task: {
          task_name: "new task",
          description: "new task description",
          completed: false,
        },
      }
      post tasks_path, params: task_hash

      # Act-Assert
      task_to_edit = Task.find_by(task_name: task_hash[:task][:task_name])
      task_to_edit.task_name = "Read a book"
      task_to_edit.save

      #DOES THIS NEED TO HAVE A PATCH PATH?

      expect(task_to_edit.task_name).must_equal "Read a book"
    end

    it "will redirect to the root page if given an invalid id" do
      # Arrange
      id = -1
      # Act
      get task_path(id) # double check this is the path I want to use

      # Assert
      must_respond_with :redirect
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "can delete a task" do
      #Arrange
      new_task = Task.create(task_name: "Do the laundry")

      expect {
        #Act
        delete task_path(new_task.id)
        #Assert
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    it "changes completed from true to false" do
      # Arrange
      new_task = Task.create(completed: false)
      patch toggle_complete_path(new_task.id)

      # Act
      new_task.reload

      # Assert
      expect(new_task.completed).must_equal true
      must_redirect_to tasks_path
    end
  end
end
