class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :kind
      t.integer :level
      t.references :user, index: true

      t.timestamps
    end
  end
end
