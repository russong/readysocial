class CreateRawData < ActiveRecord::Migration
  def change
    create_table :raw_data do |t|
      t.integer :keyword_id
      t.text :blurb
      t.text :properties

      t.timestamps
    end
    add_index :raw_data, :keyword_id
  end
end
