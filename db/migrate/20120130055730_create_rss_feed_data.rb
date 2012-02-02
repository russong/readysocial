class CreateRssFeedData < ActiveRecord::Migration
  def change
    create_table :rss_feed_data do |t|
      t.text :blurb
      t.string :name
      t.string :url
      t.string :guid
      t.datetime :published_at
      t.references :rss_feed_keyword

      t.timestamps
    end
    add_index :rss_feed_data, :rss_feed_keyword_id
    execute("alter table rss_feed_data add foreign key (rss_feed_keyword_id) references rss_feed_keywords(id);")
  end
end
