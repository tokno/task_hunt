module.exports =
    vue: null

    focusTaskNodeNextTick: (task) ->
        @vue.nextTick ->
            selector = "#task-node-#{task._id} input"
            element = document.querySelector selector
            element?.focus()

