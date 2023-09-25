const HtmlWebpackPlugin = require('html-webpack-plugin');
const path = require('path');

module.exports = {
    entry: {
        index: './src/index.js'
    },
    output: {
        filename: '[name].bundle.js',
        path: path.resolve(__dirname, 'dist'),
        clean: true,
    },
    plugins: [
        new HtmlWebpackPlugin({
            title: 'Output Management',
            inject: true,
            template: './src/index.html'
        }),
    ],
    mode: 'development',
    devtool: 'inline-source-map',
    devServer: {
        static: './dist',
    },
    target: 'web',

};