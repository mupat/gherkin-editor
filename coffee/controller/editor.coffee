fs = require 'fs'

class Editor
  constructor: ($rootScope, $scope) ->
    $scope.content = {}
    $rootScope.$on 'file.selected', (scope, file) ->
      fs.readFile file, (err, data) ->
        return console.log err if err

        $scope.$apply ->
          $scope.content.complete = data.toString()

module.exports = Editor