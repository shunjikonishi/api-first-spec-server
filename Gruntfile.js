module.exports = function(grunt) {
  "use strict";

  require('load-grunt-tasks')(grunt);
  require('time-grunt')(grunt);

  const webpackConfig = require("./webpack.config");

  grunt.initConfig({
    ts: {
      app: {
        tsconfig: true
      }
    },
    tslint: {
      options: {
        configuration: "tslint.json"
      },
      files: {
        src: ["backend/**/*.ts"]
      }
    },
    express: {
      dev: {
        options: {
          script: "./dist/server.js"
        }
      }
    },
    watch: {
      backend: {
        files: ["backend/**/*.ts"],
        tasks: ["ts", "tslint"]
      },
      frontend: {
        files: ["frontend/**/*.*"],
        tasks: ["webpack"]
      },
      express: {
        files: ["dist/**/*.js"],
        tasks: ["express"],
        options: {
          spawn: false
        }
      }
    },
    webpack: {
      options: {
        stats: !process.env.NODE_ENV || process.env.NODE_ENV === 'development'
      },
      prod: webpackConfig,
      dev: Object.assign({ 
        failOnError: true,
        cache: true
      }, webpackConfig)
    },
    concurrent: {
      backend: {
        tasks: ["tslint", "ts", "watch"],
        options: {
          logConcurrentOutput: true
        }
      },
      frontend: {
        tasks: ["webpack:dev"],
        options: {
          logConcurrentOutput: true
        }
      }
    },
  });

  grunt.registerTask("develop", ["tslint", "ts", "express", "watch"]);

  grunt.registerTask("build", [
    "tslint",
    "ts",
    "webpack:prod",
  ]);

};
