require 'rubygems'
require 'rake'
require 'echoe'

namespace :generator do
  desc "Cleans up test application"
  task :cleanup do
    FileUtils.rm_rf("test/rails_root/vendor/plugins/comfortable_mexican_sofa")
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
task :default => ['generator:cleanup', 'generator:prepare']

task :manifest => ['generator:cleanup']

Echoe.new('comfortable_mexican_sofa', '0.0.3') do |p|
  p.description    = "Open CMS Engine"
  p.url            = "http://www.theworkinggroup.ca"
  p.author         = "Oleg Khabarov"
  p.email          = "oleg@theworkinggroup.ca"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

