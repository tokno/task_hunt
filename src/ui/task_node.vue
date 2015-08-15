<style>
.sub-task-wrap {
    padding-left: 20px;
    border-left: solid 1px #ddd;
}

.task-title .pin {
    width: 1rem;
}

.task-title .text {
    width: calc(100% - 1rem);
}

.task-title .pin:hover {
    cursor: pointer;
}
</style>

<template>
<div id="task-node-{{task._id}}">
  <div class="task-title">
    <span class="pin" v-on="click: nodeSelected">-</span>
    <input class="text" v-model="title"
        v-on="keydown:newSibling | key 'enter',
              keydown:changeHierarchy | key 'tab',
              keydown:onBackKey | key '8'" />
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
            @$dispatch "node-selected", @task

        newSibling: (event) ->
            @$dispatch "request-new-task-after", @task

        changeHierarchy: (event) ->
            console.log "foo"

        onBackKey: (event) ->
            @$dispatch "delete-request", @task if !@task.title

    created: ->
        @$watch "title", =>
            @$dispatch "task-edited", @task
</script>

