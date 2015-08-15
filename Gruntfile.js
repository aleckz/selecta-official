module.exports = function(grunt) {


  grunt.initConfig({

    shell: {
      startRailsServer: {
        command: 'rails server',
        options: {
          async: true
        }
      }
    },

        // The actual grunt server settings
    connect: {
      options: {
        port: 9000,
        // Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost',
        livereload: 35729
      },
      proxies: [
        {
          context: '/api',
          host: 'localhost',
          port: 3000
        }
      ],
      livereload: {
        options: {
          open: true,
          middleware: function (connect, options) {
            if (!Array.isArray(options.base)) {
              options.base = [options.base];
            }

            // Setup the proxy
            var middlewares = [
              require('grunt-connect-proxy/lib/utils').proxyRequest,
              connect.static('.tmp'),
              connect().use(
                '/bower_components',
                connect.static('./bower_components')
              ),
              connect.static(appConfig.app)
            ];

            // Make directory browse-able.
            var directory = options.directory || options.base[options.base.length - 1];
            middlewares.push(connect.directory(directory));

            return middlewares;
          }
        }
      },
      test: {
        options: {
          port: 9001,
          middleware: function (connect) {
            return [
              connect.static('.tmp'),
              connect.static('test'),
              connect().use(
                '/bower_components',
                connect.static('./bower_components')
              ),
              connect.static(appConfig.app)
            ];
          }
        }
      },
      dist: {
        options: {
          open: true,
          base: '<%= yeoman.dist %>'
        }
      }
    }


  });

  grunt.loadNpmTasks('grunt-shell-spawn');

  grunt.registerTask('default', ['shell']);

  grunt.registerTask('serve', 'Compile then start a connect web server', function (target) {
      if (target === 'dist') {
        return grunt.task.run(['build', 'connect:dist:keepalive']);
      }

      grunt.task.run([
        'shell:startRailsServer'
      ]);
  });


};
