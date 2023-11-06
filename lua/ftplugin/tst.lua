require("typescript-tools").setup({
    settings = {
        tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeCompletionsForModuleExports = true,
            quotePreference = "auto",
        },
        code_lens = "implementations_only",
    },
})
