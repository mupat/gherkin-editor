fs = require 'fs'

class Editor
  constructor: ($rootScope, $scope) ->
    $scope.content = {}
    $scope.content.lines = []
    $rootScope.$on 'file.open.selected', (scope, file) ->
      # window.document.getElementById('editor').innerHTML = ''
      # $scope.$apply ->
      #   $scope.content.lines = []

    $rootScope.$on 'gherkin.done', (scope, content) ->
      window.document.getElementById('editor').innerHTML = ''
      $scope.$apply ->
        $scope.content.lines = content

module.exports = Editor