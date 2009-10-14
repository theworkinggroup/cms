require 'rubygems'
require 'rake'


begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'comfortable_mexican_sofa'
    gem.summary = 'ComfortableMexicanSofa is a Rails Engine CMS gem'
    gem.description = ''
    gem.email = "oleg@theworkinggroup.ca"
    gem.homepage = "http://theworkinggroup.ca"
    gem.authors = ["Oleg Khabarov, The Working Group Inc"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
    gem.rubyforge_project = 'cms-sofa'
    gem.add_dependency('haml')
    gem.add_dependency('will_paginate')
    gem.add_dependency('paperclip')
    gem.add_dependency('calendar_date_select')
    gem.add_dependency('active_link_to')
  end
  
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

namespace :generator do
  desc "Cleans up test application"
  task :cleanup do
    files = [
      'test/rails_root/vendor/plugins/comfortable_mexican_sofa',
      'test/rails_root/db',
      'test/rails_root/public/javascripts/cms',
      'test/rails_root/public/images/cms',
      'test/rails_root/tmp/',
      'test/rails_root/public/blank_iframe.html',
      'test/rails_root/public/images/calendar_date_select',
      'test/rails_root/public/javascripts/calendar_date_select/',
      'test/rails_root/public/stylesheets/calendar_date_select/',
      'test/rails_root/public/stylesheets/cms_master.css',
      'test/rails_root/config/initializers/cms.rb',
      'test/rails_root/public/system/files/'
    ]
    files.each do |file|
      FileUtils.rm_rf(file)
    end
  end
  
  desc "Run the generator on the tests"
  task :prepare do
    plugin_root = File.expand_path(File.dirname(__FILE__))
    system("ln -s #{plugin_root} test/rails_root/vendor/plugins/comfortable_mexican_sofa")
    system "cd test/rails_root && ./script/generate cms && rake db:migrate db:test:prepare"
  end
end

desc "Run the test suite"
task :default => ['generator:cleanup', 'generator:prepare', :test]
task :test => :check_dependencies
task :gemspec => ['generator:cleanup']

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "active_link_to #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }