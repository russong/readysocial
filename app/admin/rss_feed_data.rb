ActiveAdmin.register RssFeedDatum do
#  Id   |   Keyword   |   RSS Feed   |   Heading   |   URL   |   Date Published   |   Date Created   |   Date Updated.
  index do
    column :id
    column :keyword, :sortable => "rss_feed_keywords.name"  do |k|
      k.rss_feed_keyword.name
    end
    # column "RSS Feed" do |k|
    #   k.rss_feed.url
    # end
    column :heading do |k|
      k.name
    end
    column :url
    column "Date Published" do |k|
      k.published_at
    end
    column :created_at
    column :updated_at
    default_actions
  end
end
