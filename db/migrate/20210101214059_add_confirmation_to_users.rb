class AddConfirmationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmation_sent_at, :timestamp
    add_column :users, :confirmed_at, :timestamp
  end
end
