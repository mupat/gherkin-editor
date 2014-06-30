class CustomHTML
  KEYWORDS: ['feature', 'scenario', 'step', 'background']

  constructor: ->
    obj = 
      restrict: 'A'
      replace: true
      scope:
        gherkin: '='
      template: '<pre><pre>'
      link: @run.bind(@)
    return obj

  run: (scope, element, attrs) ->
    line = scope.gherkin
    html = ""

    # check if keyword need to be printed
    if line.type in @KEYWORDS
      html += "#{@_addWhitespace(line.indentation)}<strong class='keyword'>#{line.keyword}" if line.type in @KEYWORDS
      html += ":" if line.type isnt 'step'
      html += " </strong>"

    #values
    if line.type is 'table'
      for row, i in line.value
        html += @_addWhitespace(line.indentation)
        for cell, j in row
          html += '<span>|</span> ' if j is 0
          if i is 0
            html += '<strong>'
          else
            html += '<span>'
          
          html += cell

          if i is 0
            html += '</strong>'
          else
            html += '</span>'

          html += "<span> | </span>"
          html += '\n' if j is row.length - 1
    else if line.type is 'doc_string'
      html += @_addWhitespace(line.indentation) + '<span>"""</span>'
      for val in line.value.split('\n')
        html += "\n#{@_addWhitespace(line.indentation)}<span>#{val}</span>"
      html += "\n" + @_addWhitespace(line.indentation) + '<span>"""</span>'
    else
      html += @_addWhitespace(line.indentation) unless line.type in @KEYWORDS
      html += "<span class='value'>#{line.value}</span>" #print value

    # if we have a description, print it
    if line.description? and line.description.length > 0 and line.type isnt 'doc_string'
      for desc_line in line.description.split('\n')
        html += "\n#{@_addWhitespace(line.indentation)}  <span class='description'>#{desc_line}</span>"

    html += '\n'
    element.html html
 
  _addWhitespace: (indentation) ->
    Array(indentation + 1).join ' '

module.exports = CustomHTML