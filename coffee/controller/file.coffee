class File
  constructor: ($rootScope, $scope) ->
    $scope.selected = (file) ->
      $rootScope.$broadcast 'file.selected', file
  
module.exports = File