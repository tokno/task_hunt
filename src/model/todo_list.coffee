Task = require './task'
Priority = Task::Priority

class ToDoList
    @from: (rootTask) ->
        todoList = new ToDoList
        todoList.tasks = [ rootTask, rootTask.getDescendants()... ].filter (task) ->
            task.priority != Priority.Low

        todoList

    @empty: new ToDoList

    constructor: ->
        @tasks = []


module.exports = ToDoList

