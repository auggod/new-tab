require! {
  "gulp"
  "gulp-jade": jade
  "gulp-stylus": stylus
  "autoprefixer-stylus": autoprefixer
  "nib"
}

gulp.task 'templates', ->
  gulp.src('./**/*.jade')
    .pipe jade do
      pretty: true
    .pipe gulp.dest '.'

gulp.task 'stylus', ->
  gulp.src(['./app/styles/stylus/app.styl']).pipe(stylus(use: [
    nib()
    autoprefixer(browsers: [
      'iOS >= 7'
      'Chrome >= 36'
      'Firefox >= 30'
    ]) 
  ])).pipe(gulp.dest('./app/dist'))

gulp.task 'watch', ->
  gulp.watch('./**/*.jade', ['templates'])
  gulp.watch('./app/styles/**/*.styl', ['stylus'])

gulp.task 'default', [
  'stylus'
  'templates'
  'watch'
]
