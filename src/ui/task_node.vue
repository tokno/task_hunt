<style>
.task-title .pin:hover {
    cursor: pointer;
}
</style>

<template>
<div>
  <div class="task-title">
    <span class="pin" v-on="click: nodeSelected">-</span>
    <input class="text" v-model="title" />
  </div>
</div>
<div class="sub-task-wrap">
  <task-node v-repeat="subTasks"></task-node>
</div>
</template>

<script type="text/coffeescript" lang="coffee">
module.exports =
    computed:
        task: ->
            @$data

    methods:
        nodeSelected: ->
            @$dispatch "node-selected", this.task
</script>

