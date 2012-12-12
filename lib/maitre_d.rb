require 'grape'

module MaitreD
end

require 'maitre_d/heroku'
require 'maitre_d/cloud_control'
require 'maitre_d/opperator'

require 'maitre_d/engine' if defined?(Rails)
