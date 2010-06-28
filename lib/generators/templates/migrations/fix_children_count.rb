class FixChildrenCount < ActiveRecord::Migration
  def self.up
    select_values("SELECT id FROM cms_pages").each do |cms_page_id|
      children_count = select_value("
        SELECT COUNT(id)
          FROM cms_pages
          WHERE
            parent_id = %d
        " % [cms_page_id]
      )

      update_sql("
        UPDATE cms_pages
          SET children_count = %d
          WHERE
            id = %d
        " %
        [
          children_count,
          cms_page_id
        ]
      )

    end
  end

  def self.down
  end
end
