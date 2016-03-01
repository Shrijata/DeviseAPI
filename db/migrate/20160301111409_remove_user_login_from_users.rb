class RemoveUserLoginFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :user_login, :string
  end
end
