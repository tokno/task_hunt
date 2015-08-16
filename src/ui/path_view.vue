<style>
.path-divider {
    margin: 0 3px;
    color: #aaa;
}

.task-path-entry:hover {
    cursor: pointer;
    text-decoration: underline;
}
</style>
<template>
<div>
  <span v-repeat="entry : entries">
    <span v-if="$index != 0" class="path-divider">&gt;</span>
    <span class="task-path-entry" v-on="click: entrySelected(entry)">{{entry.title}}</span>
  </span>
</div>
</template>

<script type="text/coffeescript" lang="coffee">
module.exports =
    computed:
        viewPoint: ->
            @$parent.viewPoint

        path: ->
            @viewPoint?.getPath()
                .trancateTail 1

        entries: ->
            @path?.entries

    methods:
        entrySelected: (entry) ->
            @$dispatch "path-entry-selected", entry
</script>

