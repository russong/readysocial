class Trigrams::RssFeedDatum < ActiveRecord::Base
  belongs_to :rss_feed_datum, :class_name => "::RssFeedDatum"
  # attr_accessible :id, :tg
end
