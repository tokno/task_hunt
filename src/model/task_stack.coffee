class TaskStack
    constructor: ->
        @tasks = []

    size: ->
        @tasks.length

module.exports = TaskStack

