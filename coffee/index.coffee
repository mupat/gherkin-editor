gherkinEditor = angular.module 'gherkinEditor', [
  'gherkinEditor.controllers'
  'gherkinEditor.directives'
  'gherkinEditor.services'
  'ngSanitize'
]
gherkinEditor.factory '$exceptionHandler', ->
  return (exception, cause) ->
    console.log 'error', exception.message, exception.stack
    console.log 'cause', cause if cause
