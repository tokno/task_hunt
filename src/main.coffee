Vue = require './vendor/vue'
TaskStorage = require './data/mock_task_storage' # use mock

Vue.config.debug = true

# アプリケーションViewModel
window.appVm = new Vue require './ui/app.vue'

# ツリーのTaskクリック
appVm.$on "node-selected", (task) ->
    appVm.changeRoot task

# Path viewのTaskクリック
appVm.$on "path-entry-selected", (task) ->
    appVm.changeRoot task


window.onload = ->
    console.log "window loaded"

    TaskStorage.loadRoot().then (root) ->
        appVm.bindModel root
        appVm.$mount "#task-hunt-app"


