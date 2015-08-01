<script type="text/coffeescript" lang="coffee">
module.exports =
    components:
        taskRoot: require './task_root.vue'
        taskList: require './task_list.vue'
        pathView: require './path_view.vue'

    data:
        model: null
        viewPoint: null

    methods:
        bindModel: (taskTreeRoot) ->
            @model = @viewPoint = taskTreeRoot

        changeRoot: (newRoot) ->
            @viewPoint = newRoot
</script>

