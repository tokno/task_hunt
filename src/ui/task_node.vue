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

.task-title {
    border: 1px solid rgba(0, 0, 0, 0);
    border-radius: 5px;
}

.task-title.highlight {
    border-color: #ccc;
}

.task-node .high-priority .priority-mark {
    color: #f66;
}

.task-node .normal-priority .priority-mark {
    color: #6f6;
}

.task-node .low-priority .priority-mark {
    opacity: 0.1;
}

.task-node .low-priority .priority-mark:hover {
    opacity: 1;
}

.priority-mark:hover {
    cursor: pointer;
}
</style>

<template>
<div id="task-node-{{task._id}}" class="task-node {{task.priority}}-priority">
  <div class="task-title" v-class="highlight : highlight">
    <span class="priority-mark"
      v-style="margin-left: -21 * depth + 'px',
               padding-right: 21 * depth - 8 + 'px'"
      v-on="click:forwardPriority">+</span>
    <span class="pin" v-on="click: nodeSelected">-</span>
    <input class="text" v-model="title"
        v-on="keydown:newSibling | key 'enter',
              keydown:onTabKey | key 'tab',
              keydown:onBackKey | key '8'" />
  </div>
</div>
<div class="sub-task-wrap">
  <task-node v-repeat="subTasks"></task-node>
</div>
</template>

<script type="text/coffeescript" lang="coffee">
Task = require '../model/task'
Priority = Task::Priority

nextPriority = (current) ->
    priorities = [
        Priority.Low
        Priority.Normal
        # Priority.High
    ]

    idx = priorities.indexOf current
    size = priorities.length

    priorities[(idx+1) % size]


module.exports =
    computed:
        task: ->
            @$data

        depth: ->
            @task.getPath()
                .behind @$root.viewPoint
                .size()

    methods:
        nodeSelected: ->
            @$dispatch "node-selected", @task

        newSibling: (event) ->
            @$dispatch "request-new-task-after", @task

        onTabKey: (event) ->
            event.preventDefault()

            if event.shiftKey
                @$dispatch "request-task-up", @task
            else
                @$dispatch "request-task-down", @task

        onBackKey: (event) ->
            if !@task.title
                event.preventDefault()
                @$dispatch "delete-request", @task

        forwardPriority: ->
            @task.priority = nextPriority @task.priority
            @$dispatch "task-changed", @task

    created: ->
        @$add "highlight", false
        @$watch "title", =>
            @$dispatch "task-changed", @task

        @$on "task-list-item-hover", (task, hover) =>
            console.log task.title + " " + hover
            @highlight = hover if @task == task
</script>

