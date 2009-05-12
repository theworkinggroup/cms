class CmsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'migrations/create_cms.rb', 'db/migrate', :migration_file_name => 'create_cms'
    end
  end
end