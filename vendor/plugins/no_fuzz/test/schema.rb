ActiveRecord::Schema.define(:version => 0) do
  create_table :packages, :force => true do |t|
    t.string :name
  end

  create_table :trigrams_for_packages, :force => true do |t|
    t.integer :package_id
    t.string :tg
    t.integer :score, :default => 1
  end
  
  create_table :items, :force => true do |t|
    t.string :name
  end

  create_table :trigrams_for_namespaced_items, :force => true do |t|
    t.integer :item_id
    t.string :tg
    t.integer :score, :default => 1
  end
end
