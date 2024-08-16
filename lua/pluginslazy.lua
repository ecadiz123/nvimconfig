-- Lazy plugin manager y explicacion de lua:


--Primera variable local, ya que lua sin decir local hace todo global como por ejemplo variables
--lazypath: variable que guarda donde esta la data obtenida por la funcion de vim stdpath("data")
-- doble punto concadena strings
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

--if revisa que exista, si no existe corre todo el git clone para instalara lazy

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
	vim.api.nvim_echo({
	    { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
	    { out, "WarningMsg" },
	    { "\nPress any key to exit..." },
	}, true, {})
	vim.fn.getchar()
	os.exit(1)
    end
end
--comando para el "runtimepath" donde se busca opciones que no tenga por default, entonces se le añade el lugar donde se van a guardar los plugins
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup(
{
    -- Colores

    { "scottmckendry/cyberdream.nvim",
    config = function()
	vim.cmd.colorscheme("cyberdream")
    end,
},
{--treesitter
    "nvim-treesitter/nvim-treesitter",
    config= function()
	require("nvim-treesitter.configs").setup(
	{
	    ensure_installed = {"c" , "lua", "vim", "vimdoc", "query" },

	    auto_install = true,

	    highlight = {
		enable = true,
	    },
	})
    end,
},

-- Configure any other settings here. See the documentation for more details.
-- colorscheme that will be used when installing plugins.
install = { colorscheme = { "habamax" } },
-- automatically check for plugin updates
checker = { enabled = true },
})
