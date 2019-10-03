# frozen_string_literal: true

require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  
   def setup
     @user = User.create(first_name: 'Raja', last_name: 'Doe', email: 'testingexample@example.com', date_of_birth: '2001-11-5', gender: 1, password: 'password')
     @post = Post.create(title: 'test-post', body: 'this is the body of the test title', user: @user)
   end

#    test 'should be able to update post' do
#      sign_in(@user)
#      get posts_path
#      assert_template 'posts/index'
#      assert_difference 'Post.count', -1 do
#        delete post_path(@post)
#      end
#    end  

   test "should update post" do
    sign_in(@user)
    patch post_url(@post), params: { post: { title: "updated" } }
   
    assert_redirected_to posts_path
    # Reload association to fetch updated data and assert that title is updated.
    @post.reload
    assert_equal "updated", @post.title
  end


end