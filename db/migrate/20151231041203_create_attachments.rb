class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :user
      t.references :attachable, polymorphic: true, index: true
      t.string :integer

      t.timestamps null: false
    end
    add_attachment :attachments, :stuff
  end
end
