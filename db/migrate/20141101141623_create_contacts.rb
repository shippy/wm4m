class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :user, index: true
      t.string :email
      t.string :phone
      t.string :name

      t.timestamps
    end
  end
end
