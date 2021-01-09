class AddConfirmationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :confirmation_token, :integer, default: ""
    add_column :users, :confirmed, :boolean, default: false
  end
end
