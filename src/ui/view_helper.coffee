module.exports =
    vue: null

    focusTaskNodeNextTick: (task) ->
        @vue.nextTick ->
            document.querySelector "#task-node-#{task._id} input"
                .focus()

