require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
local opt = vim.opt

-- --- TU CONFIGURACIÓN DE VIM ---
opt.number = true           -- set number
opt.relativenumber = true   -- set relativenumber
opt.mouse = "a"             -- set mouse=a
opt.numberwidth = 2         -- set numberwidth=1
opt.clipboard = "unnamedplus" -- set clipboard=unnamedplus
opt.showcmd = true          -- set showcmd
opt.ruler = true            -- set ruler
opt.showmatch = true        -- set showmatch
opt.laststatus = 2          -- set laststatus=2

-- --- INDENTACIÓN (4 espacios) ---
--opt.shiftwidth = 4          -- set shiftwidth=4
--opt.tabstop = 4             
--opt.softtabstop = 4         
--opt.expandtab = true        -- set expandtab
--opt.autoindent = true       -- set autoindent
