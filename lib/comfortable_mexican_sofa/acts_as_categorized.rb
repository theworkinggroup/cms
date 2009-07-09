module ActsAsCategorized
  module StubMethods
    def acts_as_categorized
      
      include InstanceMethods
      
      # -- Attributes -------------------------------------------------------
      attr_accessor :category_items
      
      # -- Relationships ----------------------------------------------------
      has_many :cms_category_items,
        :as => :item,
        :dependent => :destroy
        
      has_many :cms_categories, 
        :through => :cms_category_items
        
      # -- Callbacks --------------------------------------------------------
      after_save :save_category_items
    end
  end
  
  module InstanceMethods
    
    # REFACTOR ME
    def save_category_items
      self.cms_category_items.destroy_all
      return if self.category_items.blank?
      self.category_items.each do |category_item|
        category = CmsCategory.find(category_item[:cms_category_id])
        self.cms_category_items.create(:cms_category_id => category.id)
        while category.parent do
          category = category.parent
          self.cms_category_items.create(:cms_category_id => category.id)
        end
      end
    end

  end
end

ActiveRecord::Base.extend(ActsAsCategorized::StubMethods)