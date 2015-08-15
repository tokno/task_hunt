Task = require '../model/task'

changeParentAll = (tasks, newParent) ->
    for task in tasks
        task.parent.removeChild task
        newParent.addChild task


saveAll = (taskRepository, tasks) ->
    new Promise (resolve, reject) =>
        if tasks.length == 0
            resolve()
        else if tasks.length == 1
            taskRepository.save tasks[0]
            .then =>
                resolve()
        else
            taskRepository.save tasks[0]
            .then =>
                saveAll taskRepository, tasks[1..-1]
            .then =>
                resolve()


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


    deleteTask: (task) ->
        task.parent.removeChild task if task.parent

        new Promise (resolve, reject) =>
            @taskRepository.deleteTask(task).then =>
                resolve()


    taskHierarchyUp: (task) ->
        return Promise.resolve() unless task.parent?.parent

        newParent = task.parent.parent
        currentParent = task.parent

        # taskの後ろの兄弟タスクは階層変更後にtaskのサブタスクになる
        len = currentParent.subTasks.length
        idx = currentParent.subTasks.indexOf task
        followingCiblings = currentParent.subTasks[idx+1..len-1]

        # 親の付け替え
        currentParent.removeChild task
        newParent.insertAfter currentParent, task

        changeParentAll followingCiblings, task

        # 保存
        new Promise (resolve, reject) =>
            @taskRepository.save(task).then =>
                saveAll @taskRepository, followingCiblings
            .then =>
                resolve()


    taskHierarchyDown: (task) ->
        # 直前の兄弟タスクが次の親になる
        newParent = task.prevSibling()

        return Promise.resolve() unless newParent

        # 親の付け替え
        task.parent.removeChild task
        newParent.addChild task

        # 保存
        @taskRepository.save task


module.exports = TaskService

