gherkin = require 'gherkin'
fs = require 'fs'

class Gherkin
  constructor: (@$rootScope) ->
    Lexer = gherkin.Lexer('en')
    @lexer = new Lexer @_gherkinFuncs()
    @$rootScope.$on 'file.selected', @_load.bind(@)

  _load: (scope, file) ->
    @content = []
    @fileContent = []
    fs.readFile file, (err, data) =>
      return @$rootScope.$emit 'error', err if err 
      try
        @fileContent = data.toString().split('\n')
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
        if last.type is 'table'
          last.value.push row
        else
          table = [row]
          @_concat 'table', 'table', table, '', line
      eof: =>
        @$rootScope.$broadcast 'gherkin.done', @content
    }

  _concat: (type, keyword, value, description, line) ->
    part = 
      type: type
      keyword: keyword
      description: description
      line: line
      value: value
      indentation: @fileContent[line - 1].search(/\S/) # get original file indentation

    @content.push part

module.exports = Gherkin