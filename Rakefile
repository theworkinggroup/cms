require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('comfortable_mexican_sofa', '0.0.1') do |p|
  p.description    = "Open CMS Engine"
  p.url            = "http://www.theworkinggroup.ca"
  p.author         = "Oleg Khabarov"
  p.email          = "oleg@theworkinggroup.ca"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

