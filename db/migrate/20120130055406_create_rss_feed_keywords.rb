class CreateRssFeedKeywords < ActiveRecord::Migration
  def change
    create_table :rss_feed_keywords do |t|
      t.references :rss_feed
      t.timestamps
    end
    add_index :rss_feed_keywords, :rss_feed_id
    execute("alter table rss_feed_keywords add foreign key (rss_feed_id) references rss_feeds(id);")
  end
end
