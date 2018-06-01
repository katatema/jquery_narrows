require "jquery_narrows/version"
require "jquery_narrows/engine"

simple_form_exist = true
begin
  require 'simple_form'
rescue LoadError
  simple_form_exist = false
end

if simple_form_exist
  require "jquery_narrows/simple_form"
end
