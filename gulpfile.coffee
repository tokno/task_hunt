gulp = require 'gulp'
source = require 'vinyl-source-stream'
browserify = require 'browserify'
glob = require 'glob'

gulp.task 'build-main', ->
    browserify
        entries: [ 'src/main.coffee' ]
        extensions: [ '.coffee', '.js' ]
    .transform 'coffeeify'
    .transform 'vueify'
    .bundle()
    .pipe source 'main.js'
    .pipe gulp.dest 'dist'


gulp.task 'default', [
    'build-main'
]

