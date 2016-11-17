var exec = require('child_process').exec;
hexo.on('new', function(data){
exec('start "D:\\Program Files\\MarkdownPad\\MarkdownPad2.exe" ' + data.path);
});


