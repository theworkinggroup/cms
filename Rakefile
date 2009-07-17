require 'rubygems'
require 'rake'
require 'echoe'

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
task :default => ['generator:cleanup', 'generator:prepare']

task :manifest => ['generator:cleanup']

Echoe.new('comfortable_mexican_sofa', '0.0.13') do |p|
  p.description    = "Ruby on Rails CMS Engine"
  p.url            = "http://www.theworkinggroup.ca"
  p.author         = "Oleg Khabarov"
  p.email          = "oleg@theworkinggroup.ca"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
  p.runtime_dependencies = [
    'haml',
    'mislav-will_paginate',
    'thoughtbot-paperclip',
    'calendar_date_select',
    'theworkinggroup-active_link_helper'
  ]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }