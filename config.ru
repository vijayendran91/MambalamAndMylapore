require './api_app'

class ApiApp
  configure do
      Mongoid.load! 'mongoid.config'
  end
end
run ApiApp.new
