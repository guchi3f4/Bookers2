class ChangeEventMailsToEventMessages < ActiveRecord::Migration[5.2]
  def change
    rename_table :event_mails, :event_messages
  end
end
