require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
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
      task = Task.create(name: "cleaning")
      valid_task_id = task.id
      # Act
      get task_path(valid_task_id)

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
          completed: false,
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

    # it "will not create a task with invalid params" do
    #   task_hash = {}
    #   expect {
    #     post tasks_path, params: task_hash
    #   }.wont_change "Book.count"

    #   must_respond_with :bad_request
    # end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      task = Task.create(name: "study")
      valid_task_id = task.id
      # Act
      get edit_task_path(valid_task_id)
      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      invalid_task_id = -1
      # Act-Assert
      get edit_task_path(invalid_task_id)
      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great thing to test.
    it "can update an existing task" do
      task = Task.create(name: "some random to dos")

      task_hash = {
        task: {
          name: "edited task",
          description: "edited description",
          completed: false,
        },
      }

      # Act-Assert
      expect {
        patch task_path(task.id), params: task_hash
      }.must_change "Task.count", 0

      edited_task = Task.find_by(name: task_hash[:task][:name])
      expect(edited_task.description).must_equal task_hash[:task][:description]
      expect(edited_task.completion_date).must_equal task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to task_path(edited_task.id)
    end

    it "will redirect to the root page if given an invalid id" do
      invalid_task_id = -1
      # Act-Assert
      get edit_task_path(invalid_task_id)
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here

  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
  end
end
