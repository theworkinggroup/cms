module ActsAsPublished
  module StubMethods
    def acts_as_published
      
      extend ClassMethods
      include InstanceMethods
      
      named_scope :published, lambda { |*at_time| {
        :conditions => published_find_conditions(*at_time)
      }}
      named_scope :unpublished, lambda { |*at_time| {
        :conditions => unpublished_find_conditions(*at_time)
      }}
    end
  end
  
  module ClassMethods
    def published_find_conditions(at_time = Time.now.utc)
      [ "(#{self.table_name}.published_at IS NOT NULL AND #{self.table_name}.published_at <= ?)
        AND
        (#{self.table_name}.unpublished_at IS NULL OR #{self.table_name}.unpublished_at > ?)", 
        at_time, at_time
      ]
    end
    
    def unpublished_find_conditions(at_time = Time.now.utc)
      [ "(#{self.table_name}.published_at IS NULL OR #{self.table_name}.published_at > ?)
        AND
        (#{self.table_name}.unpublished_at IS NULL OR #{self.table_name}.unpublished_at <= ?)",
        at_time, at_time
      ]
    end
  end
  
  module InstanceMethods
    
    def is_published?(at_time = Time.now.utc)
      published_at && published_at <= at_time && !(unpublished_at && unpublished_at <= at_time)
    end
    
    def published_status
      is_published? ? "published" : "unpublished"
    end
    
    def publish!(at_time = Time.now.utc)
      update_attributes(
        :published_at   => at_time,
        :unpublished_at => nil
      )
    end
    
    def unpublish!(at_time = Time.now.utc)
      update_attributes(
        :unpublished_at => at_time
      )
    end
  end
end

ActiveRecord::Base.extend(ActsAsPublished::StubMethods)