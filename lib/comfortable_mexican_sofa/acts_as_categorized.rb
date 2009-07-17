module ActsAsCategorized
  module StubMethods
    
    def acts_as_categorized
      
      __categorized = self.to_s.underscore
      
      # -- Attributes -------------------------------------------------------
      attr_accessor :attr_category_ids # hash that comes from the form
      
      # -- Relationships ----------------------------------------------------
      has_many "#{__categorized}_categorizations".to_sym,
        :dependent  => :destroy
      has_many :cms_categories, 
        :through    => "#{__categorized}_categorizations".to_sym
      
      # -- Callbacks --------------------------------------------------------
      after_save :save_categorizations
      
      # -- Instance Methods -------------------------------------------------
      define_method :save_categorizations do
        return if attr_category_ids.blank?

        category_ids_to_remove = attr_category_ids.select{ |k, v| v.to_i == 0}.collect{|k, v| k }
        category_ids_to_create = attr_category_ids.select{ |k, v| v.to_i == 1}.collect{|k, v| k }

        # removing unchecked categories
        send("#{__categorized}_categorizations").all(:conditions => { :cms_category_id => category_ids_to_remove}).collect(&:destroy)

        # creating categorizations
        category_ids_to_create.each do |category_id|
          send("#{__categorized}_categorizations").create(:cms_category_id => category_id)
        end
      end
    end
    
    def acts_as_categorization
      
      __categorized = self.to_s.underscore.gsub('_categorization', '')
      
      # -- Relationships --------------------------------------------------------
      belongs_to __categorized.to_sym
      belongs_to :cms_category
      
      # -- Validations ----------------------------------------------------------
      validates_presence_of "#{__categorized}_id",
                            :cms_category_id
                            
      validates_uniqueness_of "#{__categorized}_id", :scope => :cms_category_id
      
      # -- AR Callbacks ---------------------------------------------------------
      after_save :create_parent_categorization
      after_destroy :destroy_children_categorizations
      
      # -- Instance Methods -----------------------------------------------------
      define_method :create_parent_categorization do
        return unless cms_category.parent
        
        params = {
          :cms_category_id      => cms_category.parent_id,
          "#{__categorized}_id" => send(__categorized).id
        }
        self.class.create!(params) unless self.class.exists?(params)
      end
      
      define_method :destroy_children_categorizations do
        return if cms_category.children.blank?
        
        cms_category.children.each do |c|
          send(__categorized).send("#{__categorized}_categorizations").first(:conditions => {"cms_category_id" => c.id }).try(:destroy)
        end
      end
    end
  end
end

ActiveRecord::Base.extend(ActsAsCategorized::StubMethods)