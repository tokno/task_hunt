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
    font-size: 100%;
    margin: 10px;
}

.task-list-item .memo-wrap {
    background-color: #fafafa;
    box-shadow: 0px 0px 0px 1px #ddd inset;
}

.task-list-item .memo {
    font-size: 75%;
    white-space: pre;
    font-family: monospace;
    margin: 5px;
}
</style>

<template>
<li class="task-list-item">
  <div class="list-item-header">
    <div class="path" v-text="task.getPath().trancateTail()"></div>
    <div class="ops">
      <img v-if="!memoAdded" class="memo-button" v-on="click:addMemo" src="icon/memo.svg" alt="memo" />
    </div>
  </div>
  <div>
    <input class="task-title" type="text" v-model="task.title" />
  </div>
  <div v-if="memoAdded" class="memo-wrap">
    <pre class="memo" v-editable-text="task.memo" contenteditable></pre>
  </div>
</li>
</template>

<script type="text/coffeescript" lang="coffee">
module.exports =
    computed:
        task: ->
            @$data

    methods:
        addMemo: ->
            @memoAdded = true

    created: ->
        @$add "memoAdded", @task.memo
        @$watch "memo", ->
            @$dispatch "task-edited", @task

</script>

