class File
  constructor: ($rootScope, $scope) ->
    $scope.selected = (file) ->
      $rootScope.$broadcast 'file.selected', file

    $rootScope.$on 'gherkin.error', (scope, message) ->
      $scope.$apply ->
        $scope.error = message
  
module.exports = File