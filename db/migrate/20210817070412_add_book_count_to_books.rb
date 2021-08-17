class AddBookCountToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :book_count, :integer, default: 0
  end
end
