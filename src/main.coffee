Vue = require '../bower_components/vue/dist/vue.js'
TaskRepository = require './data/task_repository'
TaskService = require './service/task_service'

Vue.config.debug = true

customDirectives = require './vue_custom_directives'
customDirectives.register Vue

viewHelper = require './ui/view_helper'
viewHelper.vue = Vue

window.taskRepository = new TaskRepository
window.service = new TaskService
rootTask = null

service.taskRepository = taskRepository

# アプリケーションViewModel
window.appVm = new Vue require './ui/app.vue'

# ツリーのTaskクリック
appVm.$on "node-selected", (task) ->
    appVm.changeRoot task

# Path viewのTaskクリック
appVm.$on "path-entry-selected", (task) ->
    appVm.changeRoot task

# タスクツリーの + ボタン
appVm.$on "new-subtask", (taskParent) ->
    service.createNewSubTask(taskParent).then (newTask) ->
        viewHelper.focusTaskNodeNextTick newTask

# 新規タスク作成
appVm.$on "request-new-task-after", (task) ->
    service.createNewTask(task).then (newTask) ->
        viewHelper.focusTaskNodeNextTick newTask

# タスク削除
appVm.$on "delete-request", (task) ->
    return if task.hasSubTask()

    service.deleteTask(task).then ->
        # TODO 一つ上のタスクにフォーカス
        console.log "task deleted"

# タスクを上方向に移動
appVm.$on "request-task-up", (task) ->
    service.taskHierarchyUp(task).then =>
        viewHelper.focusTaskNodeNextTick task

# タスクを下方向に移動
appVm.$on "request-task-down", (task) ->
    service.taskHierarchyDown(task).then =>
        viewHelper.focusTaskNodeNextTick task

# 編集されたら保存
appVm.$on "task-changed", (task) ->
    taskRepository.saveTask task


window.onload = ->
    taskRepository.loadRootTask().then (root) ->
        rootTask = root
        appVm.bindModel root
        appVm.$mount "#task-hunt-app"


window.onerror = (msg, url, line, col, error) ->
    alert msg

