require "test_helper"

class AuthorTest < ActiveSupport::TestCase
  self.use_transactional_tests = false
  
  test "should not save author without email" do
    author = Author.new(first_name: "Bianca", last_name: "Binetti")
    assert_not author.save, "Saved the author without an email"
  end

  test "should not save author with duplicate email" do
    author1 = Author.create(first_name: "Olena", last_name: "Lietova", email: "letalet@gmail.com")
    author2 = Author.new(first_name: "Olena", last_name: "Letuva", email: "letalet@gmail.com")
    assert_not author2.save, "Saved an author with a duplicate email"
  end

  test "should destroy dependent articles" do
    author = Author.create!(first_name: "John", last_name: "Don", email: "john@gmail.com")
    2.times { author.articles.create!(title: "Sample Article", body: "Content Content Content", status: 'public') }

    assert_difference('Article.count', -2) do
      author.destroy
    end
  end

end
