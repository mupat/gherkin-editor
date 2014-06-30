path = "./build/js/directive/"
Change = require "#{path}change"
Gherkin = require "#{path}gherkin"

directives = angular.module 'gherkinEditor.directives', []
directives.directive 'fileChange', -> new Change()
directives.directive 'gherkin', ($compile) -> new Gherkin($compile)
