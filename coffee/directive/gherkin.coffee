class CustomHTML
  KEYWORDS: ['feature', 'scenario', 'step', 'background', 'scenario_outline', 'examples']
  INDENTATION_SPACES: 2

  constructor: ->
    obj = 
      restrict: 'A'
      replace: true
      scope:
        gherkin: '='
      link: @run.bind(@)
    return obj

  run: (scope, element, attrs) ->
    scope.$watchCollection 'gherkin', (newValue, oldValue) =>
      @_addContent element, newValue

  _addContent: (element, content) ->
    for line in content
      html = "<pre>"

      # check if keyword need to be printed
      if line.type in @KEYWORDS
        html += "#{@_addWhitespace(line.level)}<strong class='keyword'>#{line.keyword}" if line.type in @KEYWORDS
        html += ": " if line.type isnt 'step'
        html += "</strong>"

      #values
      if line.type is 'table'
        html += '<span class="table">'
        for row, i in line.value
          html += @_addWhitespace(line.level + 1)
          for cell, j in row
            html += '<span>|</span> ' if j is 0
            if i is 0
              html += '<strong class="table-head">'
            else
              html += '<span class="table-value">'
            
            html += @_addValue(cell)
            html += Array(line.description[j] - cell.length + 1).join(' ')

            if i is 0
              html += '</strong>'
            else
              html += '</span>'

            html += "<span> | </span>"
          html += '\n' unless i is line.value.length - 1
        html += '</span>'
      else if line.type is 'doc_string'
        html += @_addWhitespace(line.level) + '<span class="docstring">"""</span>'
        for val in line.value.split('\n')
          html += "\n#{@_addWhitespace(line.level)}<span>#{@_addValue(val)}</span>"
        html += "\n" + @_addWhitespace(line.level) + '<span>"""</span>'
      else
        html += @_addWhitespace(line.level) unless line.type in @KEYWORDS
        html += "<span class='value'>#{@_addValue(line.value)}</span>" #print value

      # if we have a description, print it
      if line.description? and line.description.length > 0 and line.type isnt 'doc_string' and line.type isnt 'table'
        for desc_line in line.description.split('\n')
          html += "\n#{@_addWhitespace(line.level + 1)}<span class='description'>#{desc_line}</span>"

      html += '\n'
      html += '\n' if line.blockEnd
      html += '</pre>'
      element.append html

  _addWhitespace: (level) ->
    return Array((level * @INDENTATION_SPACES) + 1).join ' '

  _addValue: (value) ->
    return value.replace('<', '<span class="placeholder">&lt;').replace('>', '&gt;</span>')

module.exports = CustomHTML