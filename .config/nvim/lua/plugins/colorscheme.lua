return {
  -- Descarga e instala el plugin
  {
    "polirritmico/monokai-nightasty.nvim",
    lazy = false, -- Asegura que se cargue al iniciar
    priority = 1000, -- Carga el tema antes que otros plugins
    config = function()
      -- Aquí puedes personalizar opciones si lo deseas
      require("monokai-nightasty").setup({
        dark_style_background = "default", -- puedes usar "darker" o "transparent"
        terminal_colors = true,
      })
    end,
  },

  -- Usar como tema principal
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai-nightasty",
    },
  },
}
