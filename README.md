````
# ubuntu常用配置

## Caps Lock 和 Esc互换
新建~/.Xmodmap
``` json
remove Lock = Caps_Lock
add Lock = Escape
keysym Caps_Lock = Escape
keysym Escape = Caps_Lock
````

## 变量

- `$MYVIMRC`

## 自带命令

`:noh` 关闭高亮，搜索后会高亮搜索部分，这个命令可以关闭高亮。
`control+f/b` 翻页
`:so %` `so` 是 `source` 的意思，`%` 代表当前文件，如果只加载 `vimrc`: `:so $MYVIMRC`

## 插件

### NERDTree

`Control + p` 搜索文件
`m->a` 新建一个文件
