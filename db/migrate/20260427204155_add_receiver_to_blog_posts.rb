class AddReceiverToBlogPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :blog_posts, :receiver_id, :integer
  end
end
