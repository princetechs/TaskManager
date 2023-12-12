=begin
Author: Hello (Sandipparida282@gmail.com)
recaptcha.rb (c) 2023
Desc: description
Created:  2023-12-12T09:56:57.763Z
Modified: !date!
=end
Recaptcha.configure do |config|
    config.secret_key =Rails.application.secrets.secret_key
    config.site_key =Rails.application.secrets.site_key
  end
  
