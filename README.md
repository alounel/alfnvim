# Neovim配置

> 简介：个人Neovim配置文件，主要用于Linux/WSL，如果在Windows下使用，可能会有些卡顿

- **注意**

1. rnvimr插件：用于在浮动窗口调用ranger，由于windows用户无法使用ranger，则需要删除此插件或者屏蔽此插件

2. nvim-genghis插件：在trashFile的配置中改为自己的绝对目录

3. sqlite.lua插件：由于Telescope frecency和yanky.nvim，以及一些其它功能需要sqlite，所以请在[sqlite.lua](https://github.com/kkharji/sqlite.lua)网站中查看详细配置

4. 需要说明的是，在将此配置使用之前，需要先修改这些设置，否则neovim使用会报错

- **基础工具**

1. 需要在系统环境中安装一些基础工具,安装：gcc,node,git,curl,wget,unzip,gzip,tar,make,fd,rg,python等

2. Windows下推荐使用Msys2安装基础工具，官网:[msys2](https://www.msys2.org)

3. 确保系统能正常连接国际互联网，即能正常访问github

## Neovim的安装

- 具体可以看[这里](https://github.com/neovim/neovim/wiki/Installing-Neovim)

## 本配置的插件安装及其使用

### 安装插件

- 准备工作完成后可以安装插件了

- linux:

- 打开终端输入: `git clone https://github.com/alounel/afnvim.git ~/.config/nvim`

- windows:

- 打开PowerShell输入: `git clone https://github.com/alounel/afnvim.git $env:LOCALAPPDATA\nvim`

- 终端输入nvim，插件便会自动安装

- 插件安装完成后，使用checkhealth命令查看有没有错误。注意：由于很多插件我使用了懒加载，要检查完成配置，需要全部启动插件。

## 基础插件介绍

### nvim-lspconfig

- 语言服务器可以自行安装，也可以通过mason.nvim插件安装。

- 使用mason.nvim安装语言服务

1. 具体需要安装的语言服务可以去mason.nvim插件的地址[mason.nvim](https://github.com/williamboman/mason.nvim)查看

2. 使用mason.nvim安装语言服务，在plugins/lsp/init.lua文件中查看语言的服务器，可以自行进行修改。

- 自行安装语言服务

1. 去nvim-lspconfig的语言服务列表[server](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)中查看

### nvim-cmp

- 基本补全已经设置，想要更加优化可以去[nvim-cmp](https://github.com/hrsh7th/nvim-cmp/wiki)查看

### nvim-dap

- Neovim没有官方的nvim-dapconfig插件，插件来源于第三方作者，可能不是那么好用，本人只完成了lua,c/c++,bash的调试配置

- 自行配置

1. 在debugger/lang/文件夹中, 添加或删除调试器配置，可以看[dapInstall](https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation),自己选择自己需要的适配器，然后修改就可以了。

2. c/c++调试：来源于lldb-vscode

3. lua调试：来源于一个插件。dap-lua.lua文件基本上不用修改。

4. bash调试，使用的是mason安装调试器，毕竟作者推荐的就是这个。

5. 如果不想neovim实现调试功能，则可以删除debugger文件夹及内部所有文件，以及plugins/dap/init.lua文件。

### Diagnotics

- 使用null-ls插件来诊断，具体的诊断程序及其配置在plugins/editor/linter/init.lua文件，对于不用的诊断程序可以删除，也可以自行添加。

### Formatter

- 使用conform.nvim可以对单个文件同时调用多个格式化程序进行格式化。

### treesitter

- treesitter语法高亮感觉比自带的好多了，不过要感觉更好看，还需要搭配一套好看的主题。

- 如果想更换主题，可以去treesitter的插件官网[Colorschemes](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes)查看

### 更多neovim插件

- 插件集合[neovim-awesome](https://github.com/rockerBOO/awesome-neovim)

## 启动优化

- 在WSL2上使用ArchLinux上进行测试，基本打开时间在70ms左右

## 自定义配置

- 每个文件夹下面都有README，介绍了每个文件的作用，如果想自己安装插件、修改配置都非常方便
