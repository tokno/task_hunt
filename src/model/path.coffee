class Path
    constructor: ->
        @entries = []
        @divider = " > "

    append: (entry) ->
        @entries.push entry
        this

    trancateTail: (length=1) ->
        index = @entries.length - length - 1
        newPath = new Path
        newPath.entries = @entries[0..index]

        newPath

    toString: ->
        @entries.join @divider


module.exports = Path

