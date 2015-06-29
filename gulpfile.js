var gulp = require('gulp');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var watchify = require('watchify');
var reactify = require('reactify');

var getBundler = function () {
    return browserify({
        entries: ['./static/app/main.jsx'],
        transform: [reactify],
        debug: true,
        cache: {}, packageCache: {}, fullPaths: true
    });
};

var bundleAndStream = function (bundler) {
    return bundler.bundle()
                .pipe(source('main.js'))
                .pipe(gulp.dest('./static/build/'));
       
};
gulp.task('browserify', function () {
    var bundler = getBundler(); 
    var watcher = watchify(bundler);

    return bundleAndStream(
        watcher
            .on('update', function(){
                var updateStart = Date.now();
                console.log('Gulping.');
                bundleAndStream(watcher);
        }));
});

gulp.task('browserifyOnce', function () {
   return bundleAndStream(getBundler());
});

gulp.task('default',['browserify']);


gulp.task('heroku:prod', ['browserifyOnce']);
