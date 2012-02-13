ActiveAdmin.register RawDatum do
  index do
    column :id
    column :keyword, :sortable => "keywords.name"  do |k|
      k.keyword.name
    end
    column :username
    column :blurb
    default_actions
  end
end
