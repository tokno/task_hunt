gulp = require 'gulp'
source = require 'vinyl-source-stream'
browserify = require 'browserify'
glob = require 'glob'

exec = require('child_process').execSync

gulp.task 'build-main', ->
    browserify
        entries: [ 'src/main.coffee' ]
        extensions: [ '.coffee', '.js' ]
    .transform 'coffeeify'
    .transform 'vueify'
    .bundle()
    .pipe source 'main.js'
    .pipe gulp.dest 'dist'


gulp.task 'doc', ->
    executable = "node_modules/codo/bin/codo"
    srcDir = "src"

    exec "#{executable} #{srcDir}",
        stdio: [ 0, 'stdout', 0 ]


gulp.task 'default', [
    'build-main'
]


gulp.task 'launch', [ 'build-main' ], ->
    electron = "node_modules/.bin/electron"
    exec "#{electron} ."

