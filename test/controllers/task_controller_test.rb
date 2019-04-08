require "test_helper"

describe TaskController do
  it "should get index" do
    get task_index_url
    value(response).must_be :success?
  end

end
