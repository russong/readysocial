class RawDatum < ActiveRecord::Base
  belongs_to :keyword
  
  default_scope eager_load(:keyword)
end
