vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
        config = function()
            require "options"
        end,
    },

    { import = "plugins" },
}, lazy_config)

require("lspconfig").nixd.setup({
    cmd = { "nixd" },
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
            },
            formatting = {
                command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
            },
            -- options = {
            --   nixos = {
            --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").nixosConfigurations.CONFIGNAME.options',
            --   },
            --   home_manager = {
            --       expr = '(builtins.getFlake "/PATH/TO/FLAKE").homeConfigurations.CONFIGNAME.options',
            --   },
            -- },
        },
    },
})


-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
    require "mappings"
end)




-- +++++++++++++++++++++ fold confg +++++++++++++++++++++++++


-- Set the color for folded text
vim.api.nvim_set_hl(0, 'Folded', { fg = '#F38BA8', bg = '#363545' })

vim.opt.foldtext = ""
-- Set foldmethod to expr
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- If using Tree-sitter
vim.opt.foldlevel = 99
