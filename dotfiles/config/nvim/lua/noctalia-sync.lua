-- Noctalia theme sync module
-- Recebe notificações do script noctalia-theme-sync e aplica o tema

local M = {}

-- Mapeamento de nomes externos -> colorscheme do neovim
local theme_map = {
    ["gruvbox-material"] = "gruvbox",
}

function M.get_theme()
    local ok, theme = pcall(require, 'current-theme')
    if ok then
        return theme_map[theme] or theme
    end
    return nil
end

function M.apply()
    local theme = M.get_theme()
    if not theme then
        vim.notify("noctalia-sync: current-theme.lua not found", vim.log.levels.WARN)
        return
    end

    -- Limpa cache do módulo para recarregar
    package.loaded['current-theme'] = nil

    -- Recarrega o tema
    theme = M.get_theme()
    if not theme then return end

    -- Aplica o tema
    local ok, err = pcall(vim.cmd.colorscheme, theme)
    if ok then
        vim.notify("Theme: " .. theme, vim.log.levels.INFO)
    else
        vim.notify("Failed to load theme: " .. theme .. " - " .. tostring(err), vim.log.levels.ERROR)
    end
end

-- Aplica tema no startup se existir
function M.setup()
    local theme = M.get_theme()
    if theme then
        vim.schedule(function()
            pcall(vim.cmd.colorscheme, theme)
        end)
    end
end

return M
