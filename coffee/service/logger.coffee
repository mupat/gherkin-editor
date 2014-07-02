class Logger
  constructor: ($rootScope) ->
    $rootScope.$on 'file.selected', (scope, file) ->
      console.log 'file selected', file

    $rootScope.$on 'gherkin.done', (scope, content) ->
      console.log 'gherkin file parse done'

    $rootScope.$on 'error', (scope, args...) ->
      console.log args...

module.exports = Logger