module.exports =
    register: (Vue) ->
        Vue.directive "editable-text",
            twoWay: true

            update: (newValue, oldValue) ->
                @el.innerText = newValue || ""

            bind: ->
                @handler = =>
                    text = @el.innerText
                    @set text

                @el.addEventListener "input", @handler

            unbind: ->
                @el.removeEventListener "input", @handler

