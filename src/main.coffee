Vue = require './vendor/vue'
TaskRepository = require './data/task_repository'
TaskService = require './service/task_service'

Vue.config.debug = true

viewHelper = require './ui/view_helper'
viewHelper.vue = Vue

window.repository = new TaskRepository
window.service = new TaskService
rootTask = null

service.taskRepository = repository

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

# 編集されたらすぐ保存
appVm.$on "task-edited", (task) ->
    repository.save task


window.onload = ->
    repository.loadRootTask().then (root) ->
        rootTask = root
        appVm.bindModel root
        appVm.$mount "#task-hunt-app"


