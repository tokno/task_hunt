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
            taskRepository.saveTask tasks[0]
            .then =>
                resolve()
        else
            taskRepository.saveTask tasks[0]
            .then =>
                saveAll taskRepository, tasks[1..-1]
            .then =>
                resolve()


class TaskService
    taskRepository: null


    # 引数のタスクに子タスクを作成する。
    createNewSubTask: (rootTask) ->
        new Promise (resolve, reject) =>
            task = new Task ""

            # ViewModelでidを使用するため、サブタスクに登録する前に保存する
            @taskRepository.saveTask(task).then (key) =>
                rootTask.addChild task
                Promise.resolve()
            .then =>
                @taskRepository.saveTask task
            .then =>
                resolve task


    # タスクを作成し、引数の次の位置に挿入する。
    createNewTask: (precedingTask) ->
        new Promise (resolve, reject) =>
            parent = precedingTask.parent

            throw "task has no parent." unless parent

            newTask = new Task ""
            @taskRepository.saveTask(newTask).then (key) =>
                parent.insertAfter precedingTask, newTask
                Promise.resolve()
            .then =>
                @taskRepository.saveTask newTask
            .then =>
                resolve newTask


    # タスク削除
    deleteTask: (task) ->
        task.parent.removeChild task if task.parent

        new Promise (resolve, reject) =>
            @taskRepository.deleteTask(task).then =>
                resolve()


    # 引数のタスクの位置を1つ浅くする
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
            @taskRepository.saveTask(task).then =>
                saveAll @taskRepository, followingCiblings
            .then =>
                resolve()


    # 引数タスクの位置を1つ深くする
    taskHierarchyDown: (task) ->
        # 直前の兄弟タスクが次の親になる
        newParent = task.prevSibling()

        return Promise.resolve() unless newParent

        # 親の付け替え
        task.parent.removeChild task
        newParent.addChild task

        # 保存
        @taskRepository.saveTask task


module.exports = TaskService

