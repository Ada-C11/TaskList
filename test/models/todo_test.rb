require "test_helper"

describe Todo do
  let(:todo) { Todo.new }

  it "must be valid" do
    value(todo).must_be :valid?
  end
end
