var gulp = require('gulp');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var watchify = require('watchify');
var reactify = require('reactify');

gulp.task('browserify', function () {
    var bundler = browserify({
        entries: ['./app/main.jsx'],
        transform: [reactify],
        debug: true,
        cache: {}, packageCache: {}, fullPaths: true
    });
    var watcher = watchify(bundler);

    return watcher
        .on('update', function(){
            var updateStart = Date.now();
            console.log('Gulping.');
            watcher
                .bundle()
                .pipe(source('main.js'))
                .pipe(gulp.dest('./build/'));
        })
        .bundle()
        .pipe(source('main.js'))
        .pipe(gulp.dest('./build/'));
});

gulp.task('default',['browserify']);
