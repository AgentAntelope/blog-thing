class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, :null => false
      t.string :persistence_token, :null => false
      t.string :encrypted_password
      t.string :salt
      t.timestamps
    end
  end
end
