module.exports = {
  mode: "production",
  entry: {
    "bundle": "./frontend/entry.js",
  },
  output: {
    path: __dirname + "/assets/",
    filename: "[name].js"
  },
  resolve: {
    extensions: [".elm", ".ts", ".js"]
  },
  module: {
    rules: [{
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      loader: 'elm-webpack-loader',
    }, {
      test: /\.ts$/,
      loader: 'ts-loader',
    }]
  }
};
