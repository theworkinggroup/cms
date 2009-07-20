class CmsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      
      # moving database migration
      if Dir.glob("db/migrate/[0-9]*_*.rb").grep(/[0-9]+_create_cms.rb$/).empty?
        m.migration_template 'migrations/create_cms.rb', 'db/migrate', :migration_file_name => 'create_cms'
      else
        puts "WARNING: Migration 'create_cms' already exists. Manually adjust it, or remove it."
      end
      
      # moving stylesheets
      if defined?(Sass)
        sass_dir = Sass::Plugin.options[:template_location].gsub(Rails.root, '') 
        m.directory sass_dir
        m.file "stylesheets/cms_master.sass", "#{sass_dir}/cms_master.sass", :collision => :ask
      else
        puts 'WARNING: HAML/SASS not installed'
      end
      
      # moving javascript
      m.directory 'public/javascripts/cms'
      %w(utilities.js mce_init.js codemirror_init.js).each do |f|
        m.file "javascripts/#{f}", "public/javascripts/cms/#{f}", :collision => :ask
      end
      
      # moving initializers
      m.directory 'config/initializers'
      %w(paperclip.rb cms.rb).each do |f|
        m.file "initializers/#{f}", "config/initializers/#{f}", :collision => :ask
      end
      
      # moving images
      m.directory 'public/images/cms'
      %w(
        arrow_bottom.gif
        arrow_right.gif
        icon_attachment.gif
        icon_category.gif
        icon_draft.gif
        icon_layout.gif
        icon_move.gif
        icon_regular.gif
        icon_snippet.gif
        logo.png
      ).each do |f|
        m.file "images/#{f}", "public/images/cms/#{f}", :collision => :ask
      end
      
      # some reading material
      m.readme 'README'
      
    end
  end
end