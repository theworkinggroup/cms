begin
  require File.join(File.dirname(__FILE__), 'lib', 'comfortable_mexican_sofa')
rescue LoadError
  require 'comfortable_mexican_sofa'
end
