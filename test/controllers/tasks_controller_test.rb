require "test_helper"

require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion_date: "date"
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
      must_respond_with :temporary_redirect
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
          completion_date: "today",
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
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      #Arrange
      existing_task = Task.create(name: "Study")

      # Act
      get edit_task_path(existing_task)
      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      bad_task_id = "THIS IS INVALID"
      # Act
      get edit_task_path(bad_task_id)
      # Assert
      must_redirect_to tasks_path
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      update_task_hash = {
        task: {
          name: "update task",
          description: "new task description",
          completion_date: "today",
        },
      }
      existing_task = Task.create(name: "Hiking", description: "fun", completion_date: "Friday")

      patch task_path(existing_task), params: update_task_hash

      existing_task.reload
      expect(existing_task.completion_date).must_equal "today"
    end

    it "will redirect to the root page if given an invalid id" do
      # Arrange
      update_task_hash = {
        task: {
          name: "update task",
          description: "new task description",
          completion_date: "today",
        },
      }
      invalid_task_id = "Invalid" 
      #Act
      patch task_path(invalid_task_id), params: update_task_hash
      # Assert
      must_redirect_to root_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "returns a 404 if the book is not found" do
      # Arrange
      invalid_task_id = "NOT A VALID ID"

      # Try to do the Books# destroy action
      expect {
        # Act
        delete task_path(invalid_task_id)
      }.must_change "Task.count", 0
      must_respond_with :not_found
    end

    it "can delete a book" do
      # Arrange - Create a book
      new_task = Task.create(name: "Study")

      expect {
        # Act
        delete task_path(new_task.id)
        # Assert
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
