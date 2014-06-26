gherkin = require 'gherkin'
fs = require 'fs'

class Gherkin
  constructor: (@$rootScope) ->
    Lexer = gherkin.Lexer('en')
    @lexer = new Lexer @_gherkinFuncs()

    @$rootScope.$on 'file.selected', @_load.bind(@)

  _load: (scope, file) ->
    fs.readFile file, (err, data) =>
      return @$rootScope.$emit 'error', err if err 
      @lexer.scan data

  _gherkinFuncs: ->
    # gherkin library functions
    return {
      comment: (value, line) =>
        # console.log({token:'comment',value:value,line:line})
      tag: (value, line) =>
        # console.log({token:'tag',value:value,line:line})
      feature: (keyword, name, description, line) =>
        console.log({token:'feature',keyword:keyword,name:name,description:description,line:line})
        @$rootScope.$broadcast 'gherkin.snippet', "<strong>#{name}</strong>"
      background: (keyword, name, description, line) =>
        # console.log({token:'background',keyword:keyword,name:name,description:description,line:line})
      scenario: (keyword, name, description, line) =>
        # console.log({token:'scenario',keyword:keyword,name:name,description:description,line:line})
      scenario_outline: (keyword, name, description, line) =>
        # console.log({token:'scenario_outline',keyword:keyword,name:name,description:description,line:line})
      examples: (keyword, name, description, line) =>
        # console.log({token:'examples',keyword:keyword,name:name,description:description,line:line})
      step: (keyword, name, line) =>
        # console.log({token:'step',keyword:keyword,name:name,line:line})
      doc_string: (content_type, string, line) =>
        # console.log({token:'doc_string',content_type:content_type,string:string,line:line})
      row: (row, line) =>
        # console.log({token:'row',row:row,line:line})
      eof: () =>
        # console.log({token:'eof'})
    }

module.exports = Gherkin