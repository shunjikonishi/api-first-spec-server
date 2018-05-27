module.exports = function(grunt) {
  "use strict";

  require('load-grunt-tasks')(grunt);
  require('time-grunt')(grunt);

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
        src: ["server/**/*.ts"]
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
        files: ["server/**/*.ts"],
        tasks: ["ts", "tslint"]
      },
      express: {
        files: ["dist/**/*.js"],
        tasks: ["express"],
        options: {
          spawn: false
        }
      }
    }
  });

  grunt.registerTask("develop", [
    "ts",
    "tslint",
    "express",
    "watch"
  ]);

  grunt.registerTask("build", [
    "ts",
    "tslint"
  ]);

};
