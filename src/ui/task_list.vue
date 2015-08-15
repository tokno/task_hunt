<style>
li {
    list-style-type: none;
}

.task-list {
    margin-left: 10px;
}

.task-list-item {
    margin: 15px 0;
    padding: 5px;
    border: 1px solid #aaa;
    border-radius: 5px;
}

.task-list-item .path {
    font-size: 60%;
    color: #666;
}

.task-list-item .task-title {
    width: calc(100% - 2px);
    margin: 2px;
}
</style>

<template>
<div class="list-header">
  <span>タスク一覧</span>
</div>
<ul class="task-list">
  <li class="task-list-item" v-repeat="task: tasks">
    <div class="path" v-text="task.getPath().trancateTail()"></div>
    <input class="task-title" type="text" v-model="task.title" />
  </li>
</ul>
</template>

<script type="text/coffeescript" lang="coffee">
module.exports =
    computed:
        tasks: ->
            @$parent.viewPoint?.getDescendants()
</script>

