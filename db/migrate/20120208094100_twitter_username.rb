class TwitterUsername < ActiveRecord::Migration
  def change
    add_column :raw_data, :username, :string
  end
end
