gulp = require 'gulp'
coffee = require 'gulp-coffee'
notify = require 'gulp-notify'

handleError = (err) ->
  this.emit 'end'

source =
  coffee: './coffee/**/*.coffee'

dest =
  js: './build/js/'

gulp.task 'coffee', ->
  gulp
    .src(source.coffee)
    .pipe(coffee({bare: true}).on('error', handleError))
    .pipe(gulp.dest(dest.js))
    .on('error', notify.onError('<%= error.message %>'))

gulp.task '_watch', ->
  gulp.watch source.coffee, ['coffee']

gulp.task 'watch', ['build', '_watch']
gulp.task 'build', ['coffee']
gulp.task 'default', ['build', 'watch']