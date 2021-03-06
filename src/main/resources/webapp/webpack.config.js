var webpack = require('webpack');
var path = require('path');
var PROD = JSON.parse(process.env.PORT || '0');
var webpackConfig = {
  entry: [
    // 'webpack-dev-server/client?http://localhost:8080',
    // 'webpack/hot/only-dev-server',
    './www/index.js'
  ],
  output: {
    path: __dirname + '/www/',
    publicPath: '/www',
    filename: 'bundle.js'
  },
  watch: true,
  module: {
    loaders: [{
        test: /\.jsx?$/,
        exclude: /node_modules/, // js / jsx
        loaders: ['babel-loader'] // is handled by babel loader with es2015 support
      },
      { test: /\.css$/, loader: "style-loader!css-loader" },
      {
        test: /\.scss$/,
        loaders: ["style", "css", "sass"]
      }
    ]
  },
  plugins: PROD ? [
    new webpack.optimize.UglifyJsPlugin({
      compress: { warnings: false }
    }),
    new webpack.DefinePlugin({
      'process.env':{
        'NODE_ENV': JSON.stringify('production')
      }
    }) 
    ] : [],
  resolve: {
    extensions: ['', '.js', '.jsx', '.css', '.scss'], // what file extensions babel looks for in imports
    root: path.resolve(__dirname), // absolute imports
    modulesDirectories: ['node_modules'], // where to look for modules
    alias: {
      // Make it so that 'require' finds the right file.
    }
  },
};

module.exports = webpackConfig;