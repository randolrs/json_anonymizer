require 'test_helper'

class AnonymizedFileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get anonymized_file_index_url
    assert_response :success
  end

  test "should get show" do
    get anonymized_file_show_url
    assert_response :success
  end

end
