require "test_helper"

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = authors(:one)
    authenticate unless @no_auth
  end

  def authenticate
    @auth_headers = { "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials("dhh", "secret") }
  end

  def skip_authentication
    @no_auth = true
  end

  test "should get index" do
    get authors_url
    assert_response :success
    assert_not_nil assigns(:authors)
  end

  test "should show" do
    get author_url(@author)
    assert_response :success
  end

  test "should get new with authentication" do
    get new_author_url, headers: @auth_headers
    assert_response :success
  end

  test "should not get new without authentication" do
    skip_authentication
    get new_author_url
    assert_response :unauthorized
  end

  test "should create author with valid parameters" do
    assert_difference('Author.count') do
      post authors_url, params: { author: { first_name: 'Anna', last_name: 'Pa', email: 'newauthor@gmail.com' } }, headers: @auth_headers
    end
    assert_redirected_to author_url(Author.last)
  end

  test "should not create author with invalid parameters" do
    assert_no_difference('Author.count') do
      post authors_url, params: { author: { first_name: 'Name', last_name: 'Surname', email: '' } }, headers: @auth_headers
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_author_url(@author), headers: @auth_headers
    assert_response :success
  end

  test "should update author" do
    patch author_url(@author), params: { author: { email: 'updatedemail@gmail.com' } }, headers: @auth_headers
    assert_redirected_to author_url(@author)
    @author.reload
    assert_equal 'updatedemail@gmail.com', @author.email
  end

  test "should not update author with invalid parameters" do
    patch author_url(@author), params: { author: { email: '' } }, headers: @auth_headers
    assert_response :unprocessable_entity
  end

  test "should destroy author" do
    assert_difference('Author.count', -1) do
      delete author_url(@author), headers: @auth_headers
    end
    assert_redirected_to root_path
  end

  test "should not create author without authentication" do
    post authors_url, params: { author: { first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com' } }
    assert_response :unauthorized
  end

  test "should not edit author without authentication" do
    get edit_author_url(@author)
    assert_response :unauthorized
  end

  test "should not delete author without authentication" do
    assert_no_difference('Author.count') do
      delete author_url(@author)
    end
    assert_response :unauthorized
  end
  

end
