class AddUserIdToPost < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.integer :user_id
    end
  end
end
