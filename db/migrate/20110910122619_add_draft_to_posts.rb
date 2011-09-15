class AddDraftToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :draft, :integer
  end
end
