class AddUserLoginToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_login, :string
  end
end
