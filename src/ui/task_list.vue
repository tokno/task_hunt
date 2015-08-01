<style>
li {
    list-style-type: none;
}

.task-list {
    margin-left: 30px;
}
</style>

<template>
<div class="list-header">
  <span>タスク一覧</span>
</div>
<ul class="task-list">
  <li v-repeat="task: tasks">
    <input type="text" v-model="task.title" />
  </li>
</ul>
</template>

<script type="text/coffeescript" lang="coffee">
module.exports =
    computed:
        tasks: ->
            @$parent.viewPoint?.getDescendants()
</script>

