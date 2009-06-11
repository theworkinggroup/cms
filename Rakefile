require 'rubygems'
require 'rake'
require 'echoe'

namespace :test do
  Rake::TestTask.new(:all => ['generator:cleanup', 'generator:prepare']) do |task|
    task.libs     << 'lib'
    task.libs     << 'test'
    task.pattern  = 'test/**/*_test.rb'
    task.verbose  = false
  end
end

namespace :generator do
  
  desc "Cleans up test application"
  task :cleanup do
    puts 'removing plugin ...'
    FileUtils.rm_rf("test/rails_root/vendor/plugins/comfortable_mexican_sofa")
    puts 'removing database ...'
    FileUtils.rm_rf("test/rails_root/db")
  end
  
  desc "Run the generator on the tests"
  task :prepare do
    plugin_root = File.expand_path(File.dirname(__FILE__))
    system("ln -s #{plugin_root} test/rails_root/vendor/plugins/comfortable_mexican_sofa")
    system "cd test/rails_root && ./script/generate cms && rake db:migrate db:test:prepare"
  end
end

desc "Run the test suite"
task :default => ['test:all']

Echoe.new('comfortable_mexican_sofa', '0.0.1') do |p|
  p.description    = "Open CMS Engine"
  p.url            = "http://www.theworkinggroup.ca"
  p.author         = "Oleg Khabarov"
  p.email          = "oleg@theworkinggroup.ca"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

