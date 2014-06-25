class Logger
  constructor: ($rootScope) ->
    $rootScope.$on 'file.selected', (scope, file) ->
      console.log 'file selected', file

module.exports = Logger