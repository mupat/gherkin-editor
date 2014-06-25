gherkinEditor = angular.module 'gherkinEditor', [
  'gherkinEditor.controllers'
  'gherkinEditor.directives'
  'gherkinEditor.services'
]
gherkinEditor.factory '$exceptionHandler', ->
  return (exception, cause) ->
    console.log 'error', exception.message, exception.stack
    console.log 'cause', cause if cause



# chooseFile = (name) ->
#   chooser = window.document.querySelector(name)
#   chooser.addEventListener "change", (evt) ->
#     console.log(this.value)

#   chooser.click()  

# chooseFile('#fileSelect');