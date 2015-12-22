class CreateEventsLogs < ActiveRecord::Migration
  def change
    create_table :events_logs do |t|
      t.string :event
      t.references :user, index: true, foreign_key: true
      t.references :logable, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
