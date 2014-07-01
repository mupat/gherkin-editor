class File
  constructor: ($rootScope, $scope) ->
    $scope.openSelected = (file) ->
      $scope.openFile = file
      $rootScope.$broadcast 'file.open.selected', file

    $scope.saveAsSelected = (file) =>
      $scope.saveFile = file
      $rootScope.$broadcast 'file.save.selected', file, @_getContent()

    $scope.saveSelected = =>
      console.log 'save selected'
      $scope.saveFile = $scope.openFile
      $rootScope.$broadcast 'file.save.selected', $scope.openFile, @_getContent()

    $rootScope.$on 'gherkin.error', (scope, message) ->
      $scope.$apply ->
        $scope.error = message

    $rootScope.$on 'file.saved', (scope) ->
      $scope.$apply ->
        $scope.error = 'file saved'
  
  _getContent: ->
    return window.document.getElementById('editor').textContent.trim()

module.exports = File