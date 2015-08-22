<style>
.task-list {
    margin-left: 10px;
}
</style>

<template>
<div class="list-header">
</div>
<ul class="task-list">
  <task-list-item  v-repeat="todoList.tasks" />
</ul>
</template>

<script type="text/coffeescript" lang="coffee">
ToDoList = require '../model/todo_list'

module.exports =
    components:
        taskListItem: require './task_list_item.vue'

    computed:
        todoList: ->
            if @$parent.viewPoint
                ToDoList.from @$parent.viewPoint
            else
                ToDoList.empty
</script>

