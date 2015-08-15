Task = require '../model/task'

class TaskEntityTransform
    objectToEntiry: (task) ->
        id: task._id
        title: task.title
        parentId: task.parent?._id
        memo: task.memo


    entityToObject: (entity) ->
        task = new Task entity.title
        task._id = entity.id
        task.parentId = entity.parentId
        task.memo = entity.memo
        task


    buildTaskTree: (tasks) ->
        # taskId -> Task のマップを作成
        map = @_buildTaskMap tasks

        # タスクツリーを構築
        @_buildHierarchy map


    _buildTaskMap: (tasks) ->
        map = {}

        for task in tasks
            key = task._id ||= "root"
            map[task._id] = task

        map


    _buildHierarchy: (taskMap) ->
        root

        for id of taskMap
            task = taskMap[id]
            parent = taskMap[task.parentId]
            delete task.parentId

            if parent
                parent.addChild task
            else
                root = task

        root




module.exports = TaskEntityTransform

