class AddDatetimeToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :datetime, :datetime
  end
end
