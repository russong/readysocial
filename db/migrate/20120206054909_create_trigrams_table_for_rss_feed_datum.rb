class CreateTrigramsTableForRssFeedDatum < ActiveRecord::Migration
  def self.up
    create_table :trigrams_for_rss_feed_data, :force => true do |t|
      t.integer :rss_feed_datum_id, :null => false
      t.string :tg, :length => 3, :null => false # trigrams
      t.integer :score, :default => 1, :null => false
    end
    add_index :trigrams_for_rss_feed_data, :tg
    add_index :trigrams_for_rss_feed_data, :rss_feed_datum_id
  end

  def self.down
    drop_table :trigrams_for_rss_feed_data
  end
end
