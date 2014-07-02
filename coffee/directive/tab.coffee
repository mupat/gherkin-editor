class Tab
  INDENTATION_SPACES: 2

  constructor: ->
    obj = 
      restrict: 'A'
      link: @run.bind(@)
    return obj
  
  run: (scope, element, attrs) ->
    element.bind 'keydown', (event) =>
      if event.which is 9 # check for tab key
        event.preventDefault() #prevent default behavior for tab
        @_insertTextAtCursor Array(@INDENTATION_SPACES).join ' '

    element.bind 'keyup', (event) =>
      anchor = window.getSelection().anchorNode
      table = window.angular.element anchor.parentNode.parentNode
      isTable = table.hasClass('table')
      if isTable
        children = table.children()

        width = []

        for child, i in children
          text = child.innerHTML.trim()
          clas = child.className
          continue unless clas is 'table-value' or clas is 'table-head'
          if width[i]?
            width[i] = text.length if width[i] < text.length
          else
            width[i] = text.length
        
        console.log 'width', width
        for child, i in children
          text = child.innerHTML.trim()
          clas = child.className
          continue unless clas is 'table-value' or clas is 'table-head'
          child.innerHTML = text + Array(width[i] - text.length + 1).join(' ')

  _insertTextAtCursor: (text) ->
    sel = window.getSelection()
    range = sel.getRangeAt 0

    range.deleteContents()

    textNode = window.document.createTextNode text
    range.insertNode textNode
    range.setStartAfter textNode
    sel.removeAllRanges()
    sel.addRange range

module.exports = Tab