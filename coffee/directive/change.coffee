class Change
  constructor: ->
    obj = 
      restrict: 'A'
      link: @run.bind(@)
    return obj

  run: (scope, element, attrs) ->
    func = scope[attrs.fileChange] # get function to execute
    element.bind 'change', ->
      func @value # call function with selected value

    element.bind 'click', ->
      element.val '' #reset value on select
   
module.exports = Change