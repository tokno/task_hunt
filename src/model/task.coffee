Path = require './path'

class Task
    constructor: (title) ->
        throw "Title must\'t be null." if title == null

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


    insertAfter: (precedingChild, newChild) ->
        idx = @subTasks.indexOf precedingChild
        len = @subTasks.length
        tasks = @subTasks

        throw "No sub-task #{precedingChild}." if idx == -1

        newChild.parent = this
        @subTasks = [tasks[0..idx]..., newChild, tasks[idx+1..len]...]


    nextSibling: ->
        myIndex = @parent.subTasks.indexOf this

        if myIndex != @parent.subTasks.length - 1
            @parent.subTasks[myIndex + 1]
        else
            null


    prevSibling: ->
        myIndex = @parent.subTasks.indexOf this

        if myIndex != 0
            @parent.subTasks[myIndex - 1]
        else
            null


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

