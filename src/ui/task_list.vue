<style>
.task-list {
    margin-left: 10px;
}
</style>

<template>
<div class="list-header">
</div>
<ul class="task-list">
  <task-list-item  v-repeat="tasks" />
</ul>
</template>

<script type="text/coffeescript" lang="coffee">
module.exports =
    components:
        taskListItem: require './task_list_item.vue'

    computed:
        tasks: ->
            @$parent.viewPoint?.getDescendants()
</script>

