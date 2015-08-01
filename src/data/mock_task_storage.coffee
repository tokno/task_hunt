Task = require '../model/task.coffee'

mockRoot = new Task "Home"

shopping = new Task "買い物"
shopping.addChild new Task "牛肉"
shopping.addChild new Task "玉ねぎ"
shopping.addChild new Task "たまご"
shopping.addChild new Task "米"

misc = new Task "雑務"
misc.addChild new Task "風呂掃除"
misc.addChild new Task "古本処分"
misc.addChild new Task "出前"

mockRoot.addChild shopping
mockRoot.addChild new Task "Task huntプロジェクト"
mockRoot.addChild misc

module.exports =
    loadRoot: ->
        new Promise (resolve, reject) ->
            setTimeout ->
                resolve mockRoot
            , 300

