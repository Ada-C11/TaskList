require "test_helper"
# test database separate from browser database
# gets cleared after every test
describe TasksController do
  let (:task) {
    Task.create name: "sample task", description: "this is an example for a test",
                completed_date: Time.now + 5.days
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
      # Task.destroy_all
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find task with id: -1"
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
      task_hash = {
        task: {
          name: "new task",
          description: "new task description",
          completed_date: nil,
        # date: "2019-04-08 16:00".to_time,
        },
      }

      # Act-Assert
      # expect {}, not interested in expression produced within {}, rather side effect
      expect {
        post tasks_path, params: task_hash
      }.must_change "Task.count", 1
      # "Task.count" code to run as string, count book before and after and make sure there is a difference of 1
      # 1 is what it should equal

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.date.to_i).must_equal task_hash[:task][:date].to_i
      expect(new_task.completed_date).must_equal task_hash[:task][:completed_date]

      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe "edit" do
    it "can get the edit page for an existing task" do
      # Act
      get edit_task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant task" do
      get edit_task_path(-1)
      must_redirect_to tasks_path
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe "update" do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    # thing to test.
    before do
      @task_hash = {
        task: {
          name: "updated task",
          description: "updated task description",
          completed_date: nil,
        # date: "2019-04-08 16:00".to_time,
        },
      }
    end
    it "can update an existing task" do
      # Arrange

      # Act
      patch task_path(task.id), params: @task_hash

      # Assert
      updated_task = Task.find_by(name: @task_hash[:task][:name])
      expect(updated_task.description).must_equal @task_hash[:task][:description]

      must_respond_with :redirect
      must_redirect_to task_path(updated_task.id)
    end

    it "will redirect to the root page if given an invalid id" do
      # Arrange
      patch task_path(-1), params: @task_hash
      # Act
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe "destroy" do
    # Your tests go here
    it "removes the task from the database" do
      # Arrange
      task = Task.create!(name: "Clean room")

      # Act
      expect {
        delete task_path(task.id)
      }.must_change "Task.count", -1

      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path

      after_task = Task.find_by(id: task.id)
      expect(after_task).must_be_nil
    end

    it "returns a 404 if the task does not exist" do
      #arrange
      task_id = 123456

      #assumptions
      expect(Task.find_by(id: task_id)).must_be_nil

      #act
      expect {
        delete task_path(task_id)
      }.wont_change "Task.count"

      #assert
      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe "toggle_complete" do
    # Your tests go here
    it "toggles successfully" do
      post complete_task_path(task.id)
      must_respond_with :redirect
      must_redirect_to tasks_path

      post incomplete_task_path(task.id)
      must_respond_with :redirect
      must_redirect_to tasks_path
    end
    # mark as not found if not found
    it "returns a 404 if given an invalid id" do
      task_id = -1
      post complete_task_path(-1)
      must_respond_with :not_found

      post incomplete_task_path(-1)
      must_respond_with :not_found
    end
  end
end
