-- 实验性lua加载器
vim.loader.enable()
-- 基础选项和快捷命令
require("core.coreinit")
-- 插件管理安装
require("boot.bootstrap")
