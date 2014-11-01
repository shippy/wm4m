class AddPebbleTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pebble_token, :string
  end
end
