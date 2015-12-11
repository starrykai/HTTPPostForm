# HTTPPostForm

iOS http post 表单上传文件

分界线单独占一行

header中指定请求编码,上传文件必须是multipart/form-data

body中,每个字段基本格式

--分界线

Content-disposition

Content-Type\n\n

filebyte

—分界线--

不同的字段之间用分界线隔开,每个空格,空行都是必须的.

