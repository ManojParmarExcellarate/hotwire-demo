class Post < ApplicationRecord
	validates_presence_of :body

	# here :posts is a name of channel we need to broadcast on
  # after_create_commit { broadcast_prepend_to :posts }
  # after_create_commit -> { broadcast_prepend_to "list_posts", partial: "posts/post", locals: { post: self }, target: "list_posts" }

  after_create_commit :broadcast_post


  def broadcast_post
  	broadcast_prepend_to('posts', partial: "posts/post", locals: { post: self }, target: "list_posts")
  end
end
