<style>
.task-root > .sub-task-wrap {
    padding-left: 20px;
    border-left: none;
}

.new-top-level-task {
    color: #999;
}

.new-top-level-task:hover {
    cursor: pointer;
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
  <div v-if="isEmpty">
    <span class="new-top-level-task" v-on="click: plusButtonClicked">+</span>
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

        isEmpty: ->
            !@rootTask?.hasSubTask()

    methods:
        plusButtonClicked: ->
            @$dispatch "new-subtask", @rootTask
</script>

