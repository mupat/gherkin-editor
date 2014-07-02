gherkin = require 'gherkin'
fs = require 'fs'

class Gherkin
  constructor: (@$rootScope) ->
    @emit = false
    Lexer = gherkin.Lexer('en')
    @lexer = new Lexer @_gherkinFuncs()
    @$rootScope.$on 'file.open.selected', @_load.bind(@)
    @$rootScope.$on 'file.save.selected', @_save.bind(@)

  _save: (scope, file, content) ->
    try
      @emit = false
      @lexer.scan content
    catch e
      @$rootScope.$emit 'error', e
      return @$rootScope.$broadcast 'gherkin.error', e.message
    
    fs.writeFile file, content, (err) =>
      return @$rootScope.$emit 'error', err if err
      @$rootScope.$emit 'file.saved'

  _load: (scope, file) ->
    @content = []
    @fileContent = []
    fs.readFile file, (err, data) =>
      return @$rootScope.$emit 'error', err if err 
      try
        @fileContent = data.toString().split('\n')
        @emit = true
        @lexer.scan data
      catch e
        @$rootScope.$emit 'error', e
        @$rootScope.$broadcast 'gherkin.error', e.message

  _gherkinFuncs: ->
    # gherkin library functions
    return {
      feature: @_concat.bind(@, 'feature')
      background: @_concat.bind(@, 'background')
      scenario: @_concat.bind(@, 'scenario')
      scenario_outline: @_concat.bind(@, 'scenario_outline')
      examples: @_concat.bind(@, 'examples')
      comment: (value, line) =>
        @_concat 'comment', 'comment', value, '', line
      tag: (value, line) =>
        @_concat 'tag', 'tag', value, '', line
      step: (keyword, name, line) =>
        @_concat 'step', keyword, name, '', line
      doc_string: (content_type, string, line) =>
        @_concat 'doc_string', 'doc_string', string, content_type, line
      row: (row, line) =>
        # combine single rows to one table element
        last = @content[@content.length - 1]

        width = []
        # calculate width
        for cell,j in row
          if last.type is 'table'
            width[j] = cell.length if width[j] < cell.length
          else
            width.push cell.length

        if last.type is 'table'
          last.value.push row
        else
          table = [row]
          @_concat 'table', 'table', table, width, line
      eof: =>
        if @emit
          @_prepare()
          @$rootScope.$broadcast 'gherkin.done', @content
    }

  _concat: (type, keyword, value, description, line) ->
    return unless @emit
    part = 
      type: type
      keyword: keyword
      description: description
      line: line
      value: value

    @content.push part

  _prepare: ->
    for part, i in @content
      if i is 0 # set default level for first entry
        part.level = 0
        part.blockEnd = false
        continue

      before = @content[i - 1]
      after = if i is @content.length - 1 then @content[i] else @content[i + 1]

      blockElements = ['scenario', 'scenario_outline', 'background', 'tag']
      part.blockEnd = (part.type not in blockElements and after.type in blockElements)
      part.level = @_calcLevel before, part if i > 0

  _calcLevel: (before, actual) ->
    #first check for fixed levels
    if actual.type is 'feature'
      return 0

    if actual.type in ['background', 'scenario', 'scenario_outline']
      return 1

    if actual.type in ['step', 'examples']
      return 2

    if actual.type is 'tag'
      if before.level > 0 #check
        return 1
      else
        return 0

    if actual.type is 'doc_string'
      return before.level + 1

    # if in contains to a block
    if before.type in ['feature', 'background', 'scenario', 'scenario_outline']
      return before.level + 1

    return before.level

module.exports = Gherkin