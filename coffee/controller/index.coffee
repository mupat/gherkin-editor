path = "./build/js/controller/"
FileCtrl = require "#{path}file"
EditorCtrl = require "#{path}editor"

editorControllers = angular.module 'gherkinEditor.controllers', []

editorControllers.controller 'FileCtrl', [
  '$rootScope'
  '$scope'
  FileCtrl
]

editorControllers.controller 'EditorCtrl', [
  '$rootScope'
  '$scope'
  EditorCtrl
]

# chatAppControllers.run ['network', 'notification', Start]
