class CmsCategoryItem < ActiveRecord::Base
  
  # -- Relationships --------------------------------------------------------
  
  belongs_to :cms_category
  belongs_to :item, :polymorphic => true 
  validates_presence_of :cms_category_id
  validates_uniqueness_of :cms_category_id, :scope => [:item_id, :item_type]
  
  # -- Named Scope ----------------------------------------------------------
  
  named_scope :of_type, lambda { |item_type|
   { :conditions =>  { :item_type => item_type.to_s.classify } }  
  }

  
end