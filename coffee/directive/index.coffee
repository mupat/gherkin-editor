path = "./build/js/directive/"
Change = require "#{path}change"

gherkinEditorDirectives = angular.module 'gherkinEditor.directives', []

gherkinEditorDirectives.directive 'fileChange', -> new Change()
