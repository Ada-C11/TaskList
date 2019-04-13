require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completion_date: nil
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
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  describe "edit" do
    it "can get the edit page for an existing task" do
      new_task = Task.new(name: "Test task", description: "Test desc")
      new_task.save

      get edit_task_path(new_task.id)

      must_respond_with :ok
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      task_id = 44444

      get edit_task_path(task_id)

      must_redirect_to tasks_path
    end
  end

  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it "can update an existing task" do
      task = Task.new(name: "new task", description: "Important")
      task.save
      new_task_params = {task: {name: "new new",
                                description: "More Important"}}

      patch task_path(task), params: new_task_params

      task.reload
      expect(task.name).must_equal "new new"
    end

    it "will redirect to the root page if given an invalid id" do
      task_id = 1111111111
      new_task_params = {task: {name: "new new",
                                description: "More Important"}}

      patch task_path(task_id), params: new_task_params

      must_respond_with :redirect
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    it "removes the record of the task from the database" do
      task = Task.create!(name: "new", description: "task")

      expect {
        delete task_path(task.id)
      }.must_change "Task.count", -1

      must_respond_with :redirect
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Create task

    # Mark task complete

    # Expect it will have a completion date
    # Must respond with redirect
  end
end
