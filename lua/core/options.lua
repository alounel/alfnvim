-- 设置leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- 自动缩进策略
vim.opt.filetype = "plugin"
-- 防止包裹
vim.wo.wrap = false
-- 默认新窗口在右和下
vim.go.splitright = true
vim.go.splitbelow = true
-- 拆分文档时行为
vim.go.splitkeep = "screen"
-- 行号显示 绝对行号和相对行号
vim.wo.number = true
vim.wo.relativenumber = true
-- 显示标尺
vim.go.ruler = true
-- 无操作时候交换文件写入磁盘等待的时间
vim.go.updatetime = 100
-- 高亮当前文本行
vim.wo.cursorline = true
-- 等待按键时长的时间
vim.go.timeout = true
vim.go.timeoutlen = 500
-- 外部修改时自动加载
vim.go.autowrite = true
vim.bo.autoread = true
-- 退出时提示确认
vim.go.confirm = true
-- 编码设置和检测
vim.bo.fileencoding = "utf-8"
vim.opt.fileencodings = { "ucs-bom", "utf-8", "utf-16", "utf-32", "gb18030", "gbk", "gb2312", "latin1" }
vim.opt.fileformats = { "unix", "dos" }
-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
-- 搜索设置
-- -- 搜索忽略大小写
vim.go.ignorecase = true
-- -- 模式中有大写字母时不忽略大小写
vim.go.smartcase = true
-- -- 搜索高亮匹配
vim.go.incsearch = true
-- -- 高亮最近的匹配搜索模式
vim.go.hlsearch = true
-- 拼写建议
vim.wo.spell = true
vim.opt.spelllang = { "en_us" }
-- 鼠标支持
vim.go.mouse = "a"
-- 启用系统剪切板
vim.opt.clipboard:append("unnamedplus")
-- 缓存文件设置
vim.go.backup = false
vim.go.writebackup = false
vim.bo.swapfile = false
-- 显示特殊字符
vim.wo.list = true
-- 空格占用以.显示
vim.opt.listchars = { space = "·", tab = "▸ ", eol = "↴" }
-- 终端24位色彩支持
vim.go.termguicolors = true
-- 判断终端是否支持真色彩，如果支持就开启，否则不开启
--if (vim.fn.has('termguicolors') == 1) then
--    vim.o.termguicolors = true
--end
-- 设置缩进
-- -- 保证在折行时维持缩进不变
vim.wo.breakindent = true
-- -- 根据上一行决定新行的缩进
vim.bo.autoindent = true
-- -- tab占用的空格数量
vim.bo.tabstop = 4
-- -- 缩进的空白长度指示
vim.bo.shiftwidth = 4
-- -- 编辑时tab使用的空格数
vim.bo.softtabstop = 4
-- -- 按下tab时替换为空格
vim.bo.expandtab = true
-- -- 缩进列数对齐到shiftwidth的整数倍
vim.go.shiftround = true
-- 插入括号时短暂跳转到另一半括号
vim.go.showmatch = true
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.go.whichwrap = "<,>,[,]"
-- 补全优化
-- -- 补全菜单背景透明
vim.go.pumblend = 10
-- -- 补全菜单长度
vim.go.pumheight = 16
-- --  'wildchar' 命令行扩展所用的模式
vim.go.wildmode = "longest:full,full"
-- -- 增强模式的命令行补全
vim.go.wildmenu = true
-- 使用增强状态栏插件后不再需要 vim 的模式提示
vim.go.showmode = false
-- redrawtime
vim.go.redrawtime = 10000
-- 菜单栏语言
vim.go.langmenu = "en_US.UTF-8"
-- 代码折叠
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldenable = true
vim.wo.foldlevel = 99
vim.go.foldlevelstart = 99
-- -- 设定指示折叠的列宽度
vim.wo.foldcolumn = "1"
-- 筛选设置
-- -- :grep使用的程序
vim.opt.grepprg = "rg --vimgrep"
-- -- grepprg输出格式
vim.opt.grepformat = "%f:%l:%c:%m"
-- 会话
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
-- 命令行高度
vim.go.cmdheight = 0
