fs = require 'fs'

class Editor
  constructor: ($rootScope, $scope) ->
    $scope.content = {}
    $scope.content.lines = []
    $rootScope.$on 'gherkin.snippet', (scope, entry) ->
      $scope.$apply ->
        $scope.content.lines.push entry

    $rootScope.$on 'gherkin.done', (scope, content) ->
      $scope.$apply ->
        $scope.content.lines = content

module.exports = Editor