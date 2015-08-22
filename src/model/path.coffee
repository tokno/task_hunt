class Path
    constructor: ->
        @entries = []
        @divider = " > "

    append: (entry) ->
        newPath = new Path
        newPath.entries = [ @entries..., entry ]

        newPath

    prepend: (entry) ->
        newPath = new Path
        newPath.entries = [ entry, @entries... ]

        newPath

    behind: (entry) ->
        idx = @entries.indexOf entry

        throw "No entry #{entry}" if idx == -1

        newPath = new Path
        newPath.entries = @entries[idx+1..-1]

        newPath

    trancateTail: (len=1) ->
        throw "error" if len < 0

        index = @entries.length - len - 1
        newPath = new Path
        newPath.entries = @entries[0..index]

        newPath

    size: ->
        @entries.length

    toString: ->
        @entries.join @divider


module.exports = Path

