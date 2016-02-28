class AddAccountSuspendedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_suspended, :boolean
  end
end
