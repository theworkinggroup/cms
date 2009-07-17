module ActsAsCategorized
  module StubMethods
    def acts_as_categorized
      
      include InstanceMethods
      
      # -- Attributes -------------------------------------------------------
      attr_accessor :attr_category_ids # hash that comes from the form
      
      # -- Relationships ----------------------------------------------------
      has_many "#{self.to_s.underscore}_categorizations",
        :dependent  => :destroy
      has_many :cms_categories, 
        :through    => "#{self.to_s.underscore}_categorizations"
      
      # -- Callbacks --------------------------------------------------------
      after_save :save_categorizations
    end
  end
  
  module InstanceMethods
    
    def save_categorizations
      return if attr_category_ids.blank?
      
      category_ids_to_remove = attr_category_ids.select{ |k, v| v.to_i == 0}.collect{|k, v| k }
      category_ids_to_create = attr_category_ids.select{ |k, v| v.to_i == 1}.collect{|k, v| k }
      
      # removing unchecked categories
      send("#{self.class.to_s.underscore}_categorizations").all(:conditions => { :cms_category_id => category_ids_to_remove}).collect(&:destroy)
      
      # creating categorizations
      category_ids_to_create.each do |category_id|
        send("#{self.class.to_s.underscore}_categorizations").create(:cms_category_id => category_id)
      end
    end
  end
end

ActiveRecord::Base.extend(ActsAsCategorized::StubMethods)