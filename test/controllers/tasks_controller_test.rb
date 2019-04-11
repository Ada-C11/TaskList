require 'test_helper'

describe TasksController do
  let(:task) {
    Task.create name: 'sample task', description: 'this is an example for a test',
                completion_date: Time.now + 5.days
  }

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
      expect(flash[:error]).must_equal 'Could not find task with id: -1'
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
          completion_date: nil,
        },
      }

      # Act-Assert
      expect {
        post tasks_path, params: task_hash
      }.must_change 'Task.count', +1

      new_task = Task.find_by(name: task_hash[:task][:name])
      expect(new_task.description).must_equal task_hash[:task][:description]
      expect(new_task.completion_date).must_equal task_hash[:task][:completion_date]

      must_respond_with :redirect
      must_redirect_to tasks_path
    end

    it 'will respond with bad request if no task is sent' do 
      # Arrange
      task_data = {}

      # Act
      expect {
        post tasks_path, params: task_data
      }.wont_change 'Task.count'

      # Assert
        must_respond_with :bad_request
    end
  end

  # Unskip and complete these tests for Wave 3
  describe 'edit' do
    it 'can get the edit page for an existing task' do
      # Arrange
      another_task = Task.create!(name: 'Test Edits', description: 'Testing the edit action')
      get edit_task_path(another_task.id)

      # Act - Assert
      must_respond_with :success
    end

    it 'will redirect if given an invalid id to edit' do
      task_id = 3000

      get edit_task_path(task_id)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Uncomment and complete these tests for Wave 3
  describe 'update' do
    # Note:  If there was a way to fail to save the changes to a task, that would be a great
    #        thing to test.
    it 'can update an existing task' do
      existing_task = Task.create!(name: 'Homework', description: 'Work on TaskList', completion_date: Time.now)
      update_task_name = { 
        task: { 
          name: 'Mario', 
          description: 'Work on TaskList',
          completion_date: Time.now,
          } 
        }

      patch task_path(existing_task.id), params: update_task_name

      expect(existing_task.name).must_equal 'Homework'
    end

    it 'will redirect to the root page if given an invalid id' do
      task_id = 1337

      patch task_path(task_id)

      must_respond_with :redirect
      must_redirect_to tasks_path
    end
  end

  # Complete these tests for Wave 4
  describe 'destroy' do
    it 'deletes a task from database' do 
      # Arrange
      task = Task.create!(name: 'Darren', description: 'Gardening')

      # Act
      expect {
        delete task_path(task)
      }.must_change 'Task.count', -1

      # Assert
      must_respond_with :redirect
      must_redirect_to tasks_path

      after_task = Task.find_by(id: task.id)
      expect(after_task).must_be_nil
    end

    it "returns a 404 if the task doesn't exist" do
      # Arrange
      task_id = 1337
      # Assumption
      expect(Task.find_by(id: task_id)).must_be_nil

      # Act
      expect {
        delete task_path(task_id)
      }.wont_change 'Task.count'

      # Assert
      must_respond_with :not_found
    end
  end

  # Complete for Wave 4
  describe 'toggle_complete' do
    # Your tests go here
  end
end
