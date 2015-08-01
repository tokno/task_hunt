class Path
    constructor: ->
        @entries = []
        @divider = " > "

    append: (entry) ->
        @entries.push entry
        this

    toString: ->
        @entries.join @divider


module.exports = Path

