Task = require '../model/task'

class TaskService
    taskRepository: null

    createNewSubTask: (rootTask) ->
        new Promise (resolve, reject) =>
            task = new Task ""

            # ViewModelでidを使用するため、サブタスクに登録する前に保存する
            @taskRepository.save(task).then (key) =>
                task._id = key # TODO repositoryに移動
                rootTask.addChild task
                Promise.resolve()
            .then =>
                @taskRepository.save task
            .then =>
                resolve task

    createNewTask: (precedingTask) ->
        new Promise (resolve, reject) =>
            parent = precedingTask.parent

            throw "task has no parent." unless parent

            newTask = new Task ""
            @taskRepository.save(newTask).then (key) =>
                newTask._id = key # TODO repositoryに移動
                parent.insertAfter precedingTask, newTask
                Promise.resolve()
            .then =>
                @taskRepository.save newTask
            .then =>
                resolve newTask



module.exports = TaskService

