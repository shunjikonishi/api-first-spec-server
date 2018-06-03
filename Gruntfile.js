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
      ts: {
        files: ["backend/**/*.ts"],
        tasks: ["ts", "tslint"]
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
      dev: Object.assign({ watch: true }, webpackConfig)
    }
  });

  grunt.registerTask("develop", [
    "ts",
    "tslint",
    "express",
    "webpack:dev",
    "watch"
  ]);

  grunt.registerTask("build", [
    "ts",
    "tslint"
  ]);

};
