<style>
li {
    list-style-type: none;
}

.task-list-item {
    margin: 15px 0;
    padding: 5px 10px;
    border: 1px solid #aaa;
    border-radius: 5px;
}

.task-list-item > .list-item-header {
    display: flex;
    border-bottom: solid 1px #ddd;
}

.task-list-item .path {
    width: 80%;
    font-size: 60%;
    color: #666;
}

.task-list-item .ops {
    width: 20%;
    font-size: 60%;
    text-align: right;
}

.ops .memo-button:hover {
    cursor: pointer;
    opacity: 0.3;
}

.task-list-item .task-title {
    width: calc(100% - 2px);
}
</style>

<template>
<li class="task-list-item">
  <div class="list-item-header">
    <div class="path" v-text="task.getPath().trancateTail()"></div>
    <div class="ops">
      <img class="memo-button" v-on="click:toggleMemo(task)" src="icon/memo.svg" alt="memo" />
    </div>
  </div>
  <input class="task-title" type="text" v-model="task.title" />
</li>
</template>

<script type="text/coffeescript" lang="coffee">
module.exports =
    computed:
        task: ->
            @$data

    methods:
        toggleMemo: (task) ->
            console.log task
</script>

