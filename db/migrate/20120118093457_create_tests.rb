class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.integer :user_id, :limit => 8
      t.timestamps
    end
  end
end
