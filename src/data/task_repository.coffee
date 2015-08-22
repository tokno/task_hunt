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


    onDatabaseUpgraded: ->
        # ルートタスクの登録
        new Promise (resolve, reject) =>
            @saveTask
                title: "Home"
            .then ->
                resolve()


    # XXX タスクの親子関係は設定されない。削除予定
    find: (id) ->
        new Promise (resolve, reject) =>
            @openReadonlyStore("task-store").then (store) ->
                request = store.get id
                request.onsuccess = (event) =>
                    task = event.target.result
                    resolve @transform.entityToObject task


    # XXX タスクの親子関係は設定されない。削除予定
    getAllTasks: ->
        new Promise (resolve, reject) =>
            @getList("task-store").then (taskList) =>
                resolve taskList.map (task) =>
                    @transform.entityToObject task


    loadRootTask: ->
        new Promise (resolve, reject) =>
            @getAllTasks().then (tasks) =>
                root = @transform.buildTaskTree tasks
                resolve root


    saveTask: (task) ->
        @saveToStore "task-store", @transform.objectToEntiry task


    deleteTask: (task) ->
        new Promise (resolve, reject) =>
            @delete("task-store", task._id).then =>
                resolve()


module.exports = TaskRepository

