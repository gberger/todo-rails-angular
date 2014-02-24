gulp   = require 'gulp'
gutil  = require 'gulp-util'
clean  = require 'gulp-clean'
watch  = require 'gulp-watch'
coffee = require 'gulp-coffee'
sass   = require 'gulp-sass'
uglify = require 'gulp-uglify'
rename = require 'gulp-rename'
concat = require 'gulp-concat'


gulp.task 'clean', ->
	gulp.src './build/*', read: false
	.pipe clean()

gulp.task 'lib', ->
	gulp.src './src/lib/**/*'
	.pipe gulp.dest './build/lib'

gulp.task 'html', ->
	gulp.src './src/**/*.html'
	.pipe gulp.dest './build'

gulp.task 'coffee', ->
	gulp.src './src/js/*.coffee'
	.pipe coffee().on('error', gutil.log)
	.pipe gulp.dest './build/js'

gulp.task 'sass', ->
	gulp.src './src/js/*.scss'
	.pipe sass()
	.pipe gulp.dest './build/css'


gulp.task 'build', ['clean', 'lib', 'html', 'coffee', 'sass']
gulp.task 'default', ['build']