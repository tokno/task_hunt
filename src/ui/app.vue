<script type="text/coffeescript" lang="coffee">
module.exports =
    components:
        taskRoot: require './task_root.vue'
        taskList: require './task_list.vue'
        pathView: require './path_view.vue'

    data:
        viewPoint: null


    methods:
        bindModel: (taskTreeRoot) ->
            @viewPoint = taskTreeRoot

        changeRoot: (newRoot) ->
            @viewPoint = newRoot

    created: ->
        @$on "task-list-item-hover", (task, hover) =>
            @$broadcast "task-list-item-hover", task, hover
</script>

