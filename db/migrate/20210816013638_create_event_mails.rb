class CreateEventMails < ActiveRecord::Migration[5.2]
  def change
    create_table :event_mails do |t|
      t.string :title
      t.text :content
      t.integer :group_id

      t.timestamps
    end
  end
end
