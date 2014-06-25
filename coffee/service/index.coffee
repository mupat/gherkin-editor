path = "./build/js/service/"
Gherkin = require "#{path}gherkin"
Logger = require "#{path}logger"

gherkinEditorServices = angular.module 'gherkinEditor.services', []

gherkinEditorServices.service 'gherkin', [
  '$rootScope'
  Gherkin
]

#run logger immediately to make sure we log sent and error events from the services that using the rootScope
gherkinEditorServices.run ['$rootScope', 'gherkin', Logger] 