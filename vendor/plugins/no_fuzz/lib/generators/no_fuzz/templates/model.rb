class Trigrams::<%= flattened_class_name -%> < ActiveRecord::Base
  belongs_to :<%= belongs_to_association %>, :class_name => "::<%= class_name %>"
  
end
