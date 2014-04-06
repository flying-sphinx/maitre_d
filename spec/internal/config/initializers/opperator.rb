require 'maitre_d/opperator'

MaitreD::Opperator.configure do |config|
  config.shared_secret = 'something-special'
  config.listener      = OpperatorListener
end
