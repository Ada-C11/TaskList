require "test_helper"

describe TasksController do
  # Note to students:  Your Task model **may** be different and
  #   you may need to modify this.
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                complete: false, complete_date: nil
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

  # Tests for Wave 2
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
          completed: false,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.complete).must_equal task_hash[:task][:complete]

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      new_task = Task.create(name: "Watch The Martian", description: "On Netflix", complete: false)

      get edit_task_path(new_task.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)

      must_respond_with :redirect
    end
  end

  # Tests for Wave 3
  describe "update" do
    it "can update an existing task" do
      # Arrange
      task = Task.create(name: "Watch The Martian", description: "On Netflix", complete: false)

      # Act
      patch task_path(task.id), params: { task: { description: "On Hulu" } }
      task.reload

      # Assert
      expect(task).wont_be_nil
      expect(task.name).must_equal "Watch The Martian"
      expect(task.description).must_equal "On Hulu"
      expect(task.complete).must_equal false

      must_respond_with :redirect
      must_redirect_to task_path(task.id)
    end

    it "will redirect to the root page if given an invalid id" do
      get edit_task_path(-1)

      must_respond_with :redirect
    end
  end

  # Tests for Wave 4
  describe "destroy" do
    it "will delete the task" do
      task = Task.create(name: "Watch The Martian", description: "On Netflix", complete: false)

      expect {
        delete task_path(task.id)
      }.must_change "Task.count", -1

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Tests for Wave 4
  describe "toggle_complete" do
    it "can mark a task complete" do
      task = Task.create(name: "Vacuum", description: "Carpeted floors", complete: false, complete_date: nil)

      travel_to Time.zone.local(2019, 4, 16, 01, 04, 44)
      patch mark_complete_path(task.id)
      task.reload

      expect(task).wont_be_nil
      expect(task.name).must_equal "Vacuum"
      expect(task.description).must_equal "Carpeted floors"
      expect(task.complete).must_equal true
      expect(task.complete_date).must_equal Date.current

      must_respond_with :redirect
      must_redirect_to task_path(task.id)
    end

    it "can mark a task incomplete" do
      task = Task.create(name: "Vacuum", description: "Carpeted floors", complete: true, complete_date: nil)

      travel_to Time.zone.local(2019, 4, 16, 01, 04, 44)
      patch mark_complete_path(task.id)
      task.reload

      expect(task).wont_be_nil
      expect(task.name).must_equal "Vacuum"
      expect(task.description).must_equal "Carpeted floors"
      expect(task.complete).must_equal false
      expect(task.complete_date).must_equal nil

      must_respond_with :redirect
      must_redirect_to task_path(task.id)
    end
  end
end
