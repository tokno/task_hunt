IndexedDBRepository = require './indexed_db_repository'
TaskEntityTransform = require './task_entity_transrotm'

# TODO サブタククの並び順を保持
class TaskRepository extends IndexedDBRepository
    scheme:
        database: "task-hunt-database"
        version: 1
        stores: [
            {
                name: "task-store"
                keyPath: "id"
                autoIncrement: true
            }
        ]


    # TODO 親クラスに移動した方がいいかも
    transform: new TaskEntityTransform


    # ルートタスクの登録
    onDatabaseUpgraded: ->
        new Promise (resolve, reject) =>
            @saveTask
                title: "Home"
            .then ->
                resolve()


    loadRootTask: ->
        new Promise (resolve, reject) =>
            @getList "task-store"
            .then (taskList) =>
                tasks = taskList.map @transform.entityToObject
                root = @transform.buildTaskTree tasks
                resolve root


    saveTask: (task) ->
        new Promise (resolve, reject) =>
            @saveToStore "task-store", @transform.objectToEntiry task
            .then (key) =>
                task._id = key if task._id == undefined
                resolve task


    deleteTask: (task) ->
        new Promise (resolve, reject) =>
            @delete("task-store", task._id).then =>
                resolve()


module.exports = TaskRepository

