const MiniCssExtractPlugin = require("mini-css-extract-plugin");

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
    }, {
      test: /\.scss$/,
      use: [
       MiniCssExtractPlugin.loader, 
        "css-loader", 
        "sass-loader",
        "import-glob-loader"
      ],
    }, {
      test: /\.css$/,
      use: [MiniCssExtractPlugin.loader, "css-loader"],
    }]
  },
  plugins: [
    new MiniCssExtractPlugin({
      // Options similar to the same options in webpackOptions.output
      // both options are optional
      filename: "[name].css",
      chunkFilename: "[id].css"
    })
  ],};
