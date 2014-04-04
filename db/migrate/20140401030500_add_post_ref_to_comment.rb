class AddPostRefToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :post, index: true
  end
end

#refencia a post de varios comentarios