<style>
.task-list-item {
    margin: 15px 5px;
    padding: 5px 10px 7px;
    border: 1px solid #aaa;
    border-radius: 5px;
}

.task-list-item:hover {
    box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.15);
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
    width: calc(100% - 22px);
    font-size: 85%;
    font-weight: bolder;
    margin: 5px;
}

.task-list-item .memo-wrap {
    padding: 5px;
    background-color: #fafafa;
    box-shadow: 0px 0px 0px 1px #ddd inset;
    border-radius: 4px;
}

.task-list-item .memo {
    font-size: 70%;
    white-space: pre;
    font-family: monospace;
    margin: 5px;
    cursor: text;
}
</style>

<template>
<li class="task-list-item" v-on="mouseover:hovered, mouseleave:leaved">
  <div class="list-item-header">
    <div class="path" v-text="pathString"></div>
    <div class="ops">
      <img v-if="!memoAdded" class="memo-button" v-on="click:addMemo"
            src="icon/memo.svg" alt="memo" />
    </div>
  </div>
  <div>
    <input class="task-title" type="text" v-model="task.title" />
  </div>
  <div v-if="memoAdded" class="memo-wrap">
    <pre class="memo" v-editable-text="task.memo" contenteditable="plaintext-only"></pre>
  </div>
</li>
</template>

<script type="text/coffeescript" lang="coffee">
module.exports =
    computed:
        task: ->
            @$data

        pathString: ->
            viewPoint = @$root.viewPoint

            # Rootから現在のタスクまでのパス。
            #
            # Root: task1, Task: task3 の場合、
            #     before: / Home / task1 / task2 / task3
            #     after: / task1 / task2
            @task.getPath()
                .behind viewPoint
                .prepend viewPoint
                .trancateTail 1

    methods:
        addMemo: ->
            @memoAdded = true

        hovered: (event) ->
            @$dispatch "task-list-item-hover", @task, true

        leaved: (event) ->
            @$dispatch "task-list-item-hover", @task, false

    created: ->
        @$add "memoAdded", @task.memo
        @$watch "memo", ->
            @$dispatch "task-changed", @task

</script>

