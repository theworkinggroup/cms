class CmsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      
      if !defined?(Sass)
        puts '/!\ Error: Please make sure application has HAML/SASS'
      else
        m.migration_template 'migrations/create_cms.rb', 'db/migrate', :migration_file_name => 'create_cms', :collision => :skip
        sass_dir = Sass::Plugin.options[:template_location].gsub(Rails.root, '') 
        m.directory sass_dir
        m.file "stylesheets/cms_master.sass", "#{sass_dir}/cms_master.sass", :collision => :skip
        m.file 'javascripts/cms_utilities.js', 'public/javascripts/cms_utilities.js', :collision => :skip
        m.file 'javascripts/cms_mce_init.js', 'public/javascripts/cms_mce_init.js', :collision => :skip
        m.file 'javascripts/cms_codemirror_init.js', 'public/javascripts/cms_codemirror_init.js', :collision => :skip
        m.file 'initializers/paperclip.rb', 'config/initializers/paperclip.rb', :collision => :skip
        
        m.readme 'README'
      end
      
    end
  end
end