local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Esto ayuda a que Plank y otros Docks reconozcan la aplicación
config.win32_system_backdrop = 'Acrylic'

config.use_fancy_tab_bar = true  -- Esto habilita la barra nativa con botones
config.show_tab_index_in_tab_bar = true

--- APARIENCIA BÁSICA ---
config.color_scheme = 'Monokai Soda'
-- Fuente con ligaduras --
config.font = wezterm.font {
  family = "JetBrains Mono Nerd Font",
  harfbuzz_features = { "liga=1", "clig=1" }
}
config.font_size = 12.0

config.window_background_opacity = 0.95
config.macos_window_background_blur = 20
config.initial_rows = 25
config.initial_cols = 95
-- --- CONFIGURACIÓN DE PESTAÑAS (COLORES MONOKAI) ---
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false -- Cámbialo a true si las prefieres abajo

config.colors = {
  tab_bar = {
    background = '#4b4b4b', -- Fondo oscuro Monokai
    active_tab = {
      bg_color = '#c4be89', -- Color "crema" de Monokai Soda
      fg_color = '#1a1a1a',
    },
    inactive_tab = {
      bg_color = '#3e3e3e',
      fg_color = '#f8f8f2',
    },
    inactive_tab_hover = {
      bg_color = '#4e4e4e',
      fg_color = '#f8f8f2',
    },
  },
}

-- --- LÓGICA DE ICONOS INTELIGENTES ---
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local pane = tab.active_pane
  local cwd_uri = pane.current_working_dir
  local title = pane.title
  local icon = ""

  if cwd_uri then
    local path = tostring(cwd_uri.file_path)

    local dir_icons = {
      { pattern = "^/etc", icon = "" },
      { pattern = "^/usr", icon = "󰏗" },
      { pattern = "^/bin", icon = "" },
      { pattern = "^/sbin", icon = "󰒓" },
      { pattern = "^/lib", icon = "󰌢" },
      { pattern = "^/boot", icon = "󰚩" },
      { pattern = "^/dev", icon = "󰋊" },
      { pattern = "^/proc", icon = "󰍛" },
      { pattern = "^/sys", icon = "󰒋" },
      { pattern = "^/var/log", icon = "󰌱" },
      { pattern = "^/var", icon = "󰉐" },
      { pattern = "^/tmp", icon = "󰜺" },
      { pattern = "^/mnt", icon = "󱗀" },
      { pattern = "^/media", icon = "󱇰" },
      { pattern = "^/srv", icon = "󰒄" },
      { pattern = "^/root", icon = "" },
      { pattern = "^/home", icon = "" },
      { pattern = "^/Users", icon = "󰠦" },
    }

    local home_icons = {
      ["Desktop"] = "󰧨",
      ["Documents"] = "󰈙",
      ["Downloads"] = "󰇚",
      ["Pictures"] = "󰉏",
      ["Music"] = "",
      ["Videos"] = "󰕧",
      ["Projects"] = "󰲋",
      [".config"] = "",
      [".cache"] = "󰃨",
      [".local"] = "󰌾",
    }

    local process_icons = {
      { match = "nvim", icon = "" },
      { match = "vim", icon = "" },
      { match = "node", icon = "󰎙" },
      { match = "python", icon = "" },
      { match = "git", icon = "" },
      { match = "docker", icon = "" },
      { match = "lazygit", icon = "" }
    }

    -- 1. Icono por ruta
    for _, rule in ipairs(dir_icons) do
      if path:match(rule.pattern) then
        icon = rule.icon
        break
      end
    end

    -- 2. Nombre carpeta
    local folder = path:match("([^/\\]+)[/\\]*$") or path
    title = folder

    -- 3. Override por carpeta home
    if home_icons[folder] then
      icon = home_icons[folder]
    end

    -- 4. Override por proceso (máxima prioridad)
    local process = pane.foreground_process_name or ""
    for _, rule in ipairs(process_icons) do
      if process:match(rule.match) then
        icon = rule.icon
        break
      end
    end
  end

  local background = '#3e3e3e'
  local foreground = '#f8f8f2'

  if tab.is_active then
    background = '#c4be89'
    foreground = '#1a1a1a'
  end

  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = '  ' .. icon .. ' ' .. title .. '  ' },
  }
end)
-- --- CURSOR Y OTROS ---
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 600

-- --- LEADER KEY & MULTIPLEXADO ---
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  { key = '-', mods = 'LEADER', action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },
  { key = '|', mods = 'LEADER', action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  { key = 'x', mods = 'LEADER', action = wezterm.action.CloseCurrentPane({ confirm = true }) },
  { key = 't', mods = 'LEADER', action = wezterm.action.SpawnTab 'DefaultDomain' },
  { key = 'LeftArrow',  mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'LEADER', action = wezterm.action.ActivatePaneDirection 'Down' },
}

-- --- INDICADOR VISUAL DE LEADER KEY ---
wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  
  -- Si la Leader Key está activa, mostramos el aviso
  if window:leader_is_active() then
    window:set_right_status(wezterm.format({
      { Background = { Color = '#fabd2f' } }, -- Color amarillo/naranja
      { Foreground = { Color = '#1a1a1a' } },
      { Attribute = { Intensity = 'Bold' } },
      { Text = '  󱔗 LEADER  ' },
    }))
  else
    -- Si no está activa, podemos poner la fecha o dejarlo vacío
    window:set_right_status(wezterm.format({
      { Foreground = { Color = '#c4be89' } },
      { Text = wezterm.strftime(' %H:%M  ') },
    }))
  end
end)

return config
