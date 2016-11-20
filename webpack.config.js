'use strict';

let webpack = require('webpack');

module.exports = {
  entry: './index.js',
  output: {
    filename: 'bundle.js'
  },
  module: {
    preLoaders: [
      { 
        test: /\.tag$/, 
        exclude: /node_modules/, 
        loader: 'riotjs-loader',
        query: { type: 'none' }
      }
    ],
    loaders: [
      { 
        test: /\.tag$/, 
        exclude: /node_modules/, 
        loader: 'riotjs-loader'
      },
      {
        test: /\.es6|js|tag$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015']
        }
      },
      {
        test: /\.js|\.html$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      }
    ]
  },
  plugins: [
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.ProvidePlugin({riot: 'riot'})
  ]
};