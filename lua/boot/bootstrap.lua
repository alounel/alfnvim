local uv = vim.loop or vim.uv

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
        -- colorscheme
        -- { import = "plugins.extras.colorscheme.kanagawa" },
        -- { import = "plugins.extras.colorscheme.monokaipro" },
        -- { import = "plugins.extras.colorscheme.nightfox" },
        -- { import = "plugins.extras.colorscheme.onenord" },
        -- dap
        { import = "plugins.extras.dap.luadap" }, -- 特定语言调试插件
        -- develop
        { import = "plugins.extras.develop.bigfile" }, -- 大文件控制
        { import = "plugins.extras.develop.comments" }, -- 快速注释
        { import = "plugins.extras.develop.compiler" }, -- 构建和运行代码
        { import = "plugins.extras.develop.font-icon" }, -- 图标选择
        { import = "plugins.extras.develop.commander" }, -- 查找命令以及按键绑定
        { import = "plugins.extras.develop.chainsaw" }, -- 创建特定语言日志
        -- editor
        { import = "plugins.extras.editor.autotools" }, -- 自动处理工具
        { import = "plugins.extras.editor.replacer" }, -- 参数替换
        { import = "plugins.extras.editor.stamps" }, -- 文本标记
        { import = "plugins.extras.editor.portal" }, -- 位置列表导航
        { import = "plugins.extras.editor.surround" }, -- 修改定界符
        -- { import = "plugins.extras.develop.refactor" }, -- 代码重构
        -- elevate
        { import = "plugins.extras.elevate.scope" }, -- 增强选项卡范围
        { import = "plugins.extras.elevate.escape" }, -- 更好的模式切换
        { import = "plugins.extras.elevate.scroll" }, -- 平滑滚动
        { import = "plugins.extras.elevate.substitute" }, -- 代替内置substitute
        -- explorer
        { import = "plugins.extras.explorer" }, -- 更多文件浏览工具
        -- git
        { import = "plugins.extras.git" }, -- 优秀git工具
        -- line
        -- { import = "plugins.extras.line.sideline" }, -- 侧边栏
        -- { import = "plugins.extras.line.statusLine" }, -- 状态栏
        -- { import = "plugins.extras.line.tabline" }, -- tabline
        -- lsp lang
        { import = "plugins.extras.lsp.lang.clangd" },
        -- { import = "plugins.extras.lsp.lang.java" },
        { import = "plugins.extras.lsp.lang.jqx" },
        { import = "plugins.extras.lsp.lang.typescript" },
        -- lsp strength
        { import = "plugins.extras.lsp.strength.aerial" }, -- 代码大纲
        -- { import = "plugins.extras.lsp.strength.dropbar" },
        { import = "plugins.extras.lsp.strength.fidget" }, -- LSP 进度提示
        { import = "plugins.extras.lsp.strength.illuminate" }, -- 显示光标下相同词汇
        { import = "plugins.extras.lsp.strength.increname" }, -- 基于LSP带有即时视觉反馈的重命名
        { import = "plugins.extras.lsp.strength.lspsaga" }, -- 改善 Neovim LSP 体验
        { import = "plugins.extras.lsp.strength.naybuddy" }, -- 浮动导航窗口
        { import = "plugins.extras.lsp.strength.outline" }, -- 符号大纲
        -- search
        { import = "plugins.extras.fzf" }, -- fzf搜索
        -- treesitter
        { import = "plugins.extras.treesitter.treesj" }, -- 分割/合并代码
        { import = "plugins.extras.treesitter.context" }, -- 上下文环境
        { import = "plugins.extras.treesitter.autotag" }, -- 自动关闭标签
        { import = "plugins.extras.treesitter.commentstring" }, -- 注释
        -- ui
        -- { import = "plugins.extras.ui.alpha" },
        -- { import = "plugins.extras.ui.starter" },
        { import = "plugins.extras.ui.dashboard" }, -- 启动界面
        -- { import = "plugins.extras.ui.annotbox" }, -- 注释美化
        { import = "plugins.extras.ui.colorizer" }, -- 16进制颜色
        { import = "plugins.extras.ui.edgy" }, -- 预定义布局
        { import = "plugins.extras.ui.hlslens" }, -- 搜索高亮条目
        { import = "plugins.extras.ui.rainbow" }, -- 彩虹括号
        { import = "plugins.extras.ui.indentstyle" }, -- 缩进样式
        -- utils
        { import = "plugins.extras.utils.startuptime" }, -- 测量启动时间
    },
    defaults = { version = false },
    install = { colorscheme = { "tokyonight", "nightfox", "habamax" } },
    ui = {
        border = "rounded",
        icons = {
            ft = "",
            loaded = "",
            not_loaded = "",
        },
    },
    custom_keys = {
        ["<localleader>l"] = false,
        ["<localleader>t"] = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "2html_plugin",
                "bugreport",
                "compiler",
                "editorconfig",
                "ftplugin",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logiPat",
                "matchit",
                "matchparen",
                "netrw",
                "netrwFileHandlers",
                "netrwPlugin",
                "netrwSettings",
                "optwin",
                "remote_plugins",
                "rplugin",
                "rrhelper",
                "shada",
                "shada_plugin",
                "spellfile",
                "spellfile_plugin",
                "synmenu",
                "syntax",
                "tar",
                "tarPlugin",
                "tohtml",
                "tutor",
                "tutor_mode_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
            },
        },
    },
})

-- lazy.nvim按键绑定
require("boot.keymaps")
