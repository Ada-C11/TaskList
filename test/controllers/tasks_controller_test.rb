require 'test_helper'

describe TasksController do
  let (:task) do
    Task.create name: 'sample task', description: 'this is an example for a test',
                completion_date: Time.now + 5.days
  end

  # Tests for Wave 1
  describe 'index' do
    it 'can get the index path' do
      # Act
      get tasks_path

      # Assert
      must_respond_with :success
    end

    it 'can get the root path' do
      # Act
      get root_path

      # Assert
      must_respond_with :success
    end
  end

  # Unskip these tests for Wave 2
  describe 'show' do
    it 'can get a valid task' do
      # Act
      get task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it 'will redirect for an invalid task' do
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  describe 'new' do
    it 'can get the new task page' do
      # Act
      get new_task_path

      # Assert
      must_respond_with :success
    end
  end

  describe 'create' do
    it 'can create a new task' do
      # Arrange
      task_hash = {
        task: {
          name: 'new task',
          description: 'new task description',
          completion_date: nil
        }
      }

      # Act-Assert
      expect do
        post tasks_path, params: task_hash
      end.must_change 'Task.count', 1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]
      must_respond_with :redirect
      must_redirect_to task_path(new_task.id)
    end
  end

  # Unskip and complete these tests for Wave 3
  describe 'edit' do
    it 'can get the edit page for an existing task' do
      # Act
      get edit_task_path(task.id)

      # Assert
      must_respond_with :success
    end

    it 'will respond with redirect when attempting to edit a nonexistant task' do
      # Act
      get task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe 'update' do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it 'can update an existing task' do
      # Arrange
      task = Task.create!(name: 'read a book')
      task_data = {
        task: {
          name: 'watch a panopto video'
        }
      }

      # Act
      patch task_path(task), params: task_data

      # Assert
      must_respond_with :redirect
      must_redirect_to task_path(task)

      task.reload
      expect(task.name).must_equal(task_data[:task][:name])
    end

    it 'will redirect to the root page if given an invalid id' do
      # Act
      patch task_path(-1)

      # Assert
      must_respond_with :redirect
    end
  end

  # Complete these tests for Wave 4
  describe 'destroy' do
    it 'removes the task from the database' do
      # Arrange
      task = Task.create!(name: 'read a book')

      # Act
      expect do
        delete task_path(task)
      end.must_change 'Task.count', -1

      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path

      after_task = Task.find_by(id: task.id)
      expect(after_task).must_be_nil
    end

    it "returns a 404 if the task doesn't exist" do
      # Arrange
      task_id = 8_999_977

      expect(Task.find_by(id: task_id)).must_be_nil

      # Act
      expect do
        delete task_path(task_id)
      end.wont_change 'Task.count'

      # Assert
      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe 'toggle_complete' do
    it 'can mark a task as complete' do
      # Arrange
      task = Task.create!(
        name: 'read POODR',
        description: 'Answer Ch4 questions'
      )
      date = Date.current
      # Act
      patch toggle_complete_path(task)

      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path

      task.reload
      expect(task.completion_date).must_equal(date)
    end

    it 'can mark a task as incomplete' do
      # Arrange
      task = Task.create!(
        name: 'read POODR',
        description: 'Answer Ch4 questions',
        completion_date: 'Apr 29, 2020'
      )

      # Act
      patch toggle_complete_path(task)

      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path

      task.reload
      expect(task.completion_date).must_be_nil
    end
  end
end
