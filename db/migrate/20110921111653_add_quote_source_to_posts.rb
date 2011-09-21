class AddQuoteSourceToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :quote_source, :string
  end
end
