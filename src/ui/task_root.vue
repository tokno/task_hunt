<style>
.sub-task-wrap {
    padding-left: 30px;
    border-left: solid 1px #ddd;
}
</style>

<template>
<div class="task-root task-node">
  <div class="title-wrap">
    <span>{{title}}</span>
  </div>
  <div class="sub-task-wrap">
    <task-node v-repeat="subTasks"></task-node>
  </div>
</div>
</template>

<script type="text/coffeescript" lang="coffee">
module.exports =
    components:
        taskNode: require './task_node.vue'

    computed:
        rootTask: ->
            @$parent.viewPoint

        task: ->
            @rootTask

        title: ->
            @rootTask?.title

        subTasks: ->
            @rootTask?.subTasks
</script>

