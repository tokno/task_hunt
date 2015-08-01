Path = require './path'

class Task
    constructor: (title) ->
        throw "Title must\'t be empty." if !title

        @title = title
        @parent = null
        @subTasks = []

    addChild: (task) ->
        @subTasks.push task
        task.parent = this
        this

    removeChild: (task) ->
        index = @subTasks.indexOf task
        @subTasks.splice index, 1 if index != -1
        this

    hasSubTask: ->
        @subTasks.length

    getPath: ->
        if @parent
            @parent.getPath().append this
        else
            new Path().append this

    walkAllChildNode: (fn) ->
        @subTasks.forEach (subTask) ->
            fn subTask
            subTask.walkAllChildNode fn

    getDescendants: ->
        tasks = []
        @walkAllChildNode (task) -> tasks.push task
        tasks

    toString: ->
        @title


module.exports = Task

