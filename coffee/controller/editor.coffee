fs = require 'fs'

class Editor
  constructor: ($rootScope, $scope) ->
    $scope.content = {}
    $scope.content.lines = []
    $rootScope.$on 'gherkin.snippet', (scope, entry) ->
      console.log 'get snippet', entry
      $scope.$apply ->
        $scope.content.lines.push entry

module.exports = Editor