class AddAuthorToTask < ActiveRecord::Migration
  def change
    add_reference :tasks, :author, index: true, foreign_key: true
  end
end
