-- init.lua - Configuração minimalista do Neovim para Markdown
-- Coloque este arquivo em: ~/.config/nvim/init.lua

-- ============================================================================
-- CONFIGURAÇÕES BÁSICAS
-- ============================================================================

vim.opt.guifont = "JetBrainsMono Nerd Font:h12"


-- Números de linha
vim.opt.number = true           -- Mostra número da linha
vim.opt.relativenumber = true   -- Números relativos (facilita navegação)

-- Indentação
vim.opt.expandtab = true        -- Usa espaços em vez de tabs
vim.opt.tabstop = 2             -- Tab = 2 espaços
vim.opt.shiftwidth = 2          -- Indentação automática = 2 espaços
vim.opt.softtabstop = 2

-- Busca
vim.opt.ignorecase = true       -- Ignora maiúsculas/minúsculas na busca
vim.opt.smartcase = true        -- Mas respeita se você digitar maiúscula
vim.opt.hlsearch = true         -- Destaca resultados da busca
vim.opt.incsearch = true        -- Busca incremental

-- Interface
vim.opt.wrap = true             -- Quebra linhas longas (importante para Markdown)
vim.opt.linebreak = true        -- Quebra em palavras, não no meio delas
-- vim.opt.mouse = 'a'          -- Habilita o mouse
vim.opt.mouse = ''              -- Desabilita o mouse

vim.opt.termguicolors = true    -- Cores de 24-bit
vim.opt.cursorline = true      -- Destaca linha atual
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1f1f2e" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#1c1c2b" })


vim.opt.signcolumn = 'yes'      -- Coluna para símbolos (git, erros, etc)

-- Comportamento
vim.opt.swapfile = false        -- Desabilita arquivos .swp
vim.opt.backup = false          -- Desabilita backups automáticos
vim.opt.undofile = true         -- Habilita histórico de desfazer persistente
vim.opt.clipboard = 'unnamedplus' -- Usa clipboard do sistema

-- Tecla líder (usada para atalhos personalizados)
vim.g.mapleader = ' '           -- Espaço como tecla líder


-- ============================================================================
-- GERENCIADOR DE PLUGINS (lazy.nvim)
-- ============================================================================

-- Instala o lazy.nvim automaticamente se não existir
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- ============================================================================
-- PLUGINS
-- ============================================================================

require("lazy").setup({


-- Tema: Cyberdream (tema cyberpunk moderno)

{
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
},

  -- Telescope: Busca fuzzy de arquivos (como Ctrl+P do VS Code)
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" }
        }
      })
    end,
  },

  -- Markdown Preview: Visualiza Markdown no navegador
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },


  -- Auto-pairs: Fecha parênteses, colchetes automaticamente
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Lualine: Barra de status bonita
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = 'cyberdream',
          component_separators = '|',
          section_separators = '',
        }
      })
    end,
  },

  -- Markdown específico: Headlines (destaca títulos)
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = "markdown",
    config = function()
      require("headlines").setup({
        markdown = {
          headline_highlights = {
            "Headline1",
            "Headline2",
            "Headline3",
            "Headline4",
            "Headline5",
            "Headline6",
          },
        },
      })
    end,
  },

-- Zen Mode

{
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  config = function()
    require("zen-mode").setup({
      window = {
        width = 90,
      },
      plugins = {
        options = {
          showcmd = false,
          ruler = false,
        },
      },
    })
  end,
},

-- devicons

{
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "slant",
      },
    })
  end,
},

-- Glow Plugin
{
  "ellisonleao/glow.nvim",
  cmd = "Glow",
  config = function()
    require("glow").setup({
      border = "rounded",
      style = "dark",
      width = 120,
    })
  end,
},




})

vim.cmd("colorscheme cyberdream")

require("cyberdream").setup({
  transparent = false,
  italic_comments = true,
  hide_fillchars = false,
  borderless_pickers = true,
  terminal_colors = true,
})


-- Headlines (já existentes, mantidos aqui)
vim.api.nvim_set_hl(0, "Headline1", { fg = "#ff5f87", bold = true })
vim.api.nvim_set_hl(0, "Headline2", { fg = "#ffaf5f", bold = true })
vim.api.nvim_set_hl(0, "Headline3", { fg = "#5fd7ff", bold = true })
vim.api.nvim_set_hl(0, "Headline4", { fg = "#87ffaf", bold = true })


-- ============================================================================
-- ATALHOS PERSONALIZADOS
-- ============================================================================

local keymap = vim.keymap.set

-- Salvar e sair
keymap('n', '<leader>w', ':w<CR>', { desc = 'Salvar arquivo' })
keymap('n', '<leader>q', ':q<CR>', { desc = 'Sair' })

-- Limpar destaque da busca
keymap('n', '<Esc>', ':noh<CR>', { desc = 'Limpar busca' })

-- Navegação entre janelas
keymap('n', '<C-h>', '<C-w>h', { desc = 'Ir para janela esquerda' })
keymap('n', '<C-j>', '<C-w>j', { desc = 'Ir para janela abaixo' })
keymap('n', '<C-k>', '<C-w>k', { desc = 'Ir para janela acima' })
keymap('n', '<C-l>', '<C-w>l', { desc = 'Ir para janela direita' })

-- Telescope (busca de arquivos)
keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Buscar arquivos' })
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Buscar em arquivos' })
keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Listar buffers' })

-- Markdown Preview
keymap('n', '<leader>mp', '<cmd>MarkdownPreview<cr>', { desc = 'Markdown Preview' })
keymap('n', '<leader>ms', '<cmd>MarkdownPreviewStop<cr>', { desc = 'Parar Preview' })

-- Navegação no texto com quebra de linha
keymap('n', 'j', 'gj', { desc = 'Descer linha visual' })
keymap('n', 'k', 'gk', { desc = 'Subir linha visual' })

-- Toggle Zen-mode
keymap('n', '<leader>z', '<cmd>ZenMode<cr>', { desc = 'Modo foco' })


-- Markdown Preview
vim.keymap.set('n', '<leader>mg', '<cmd>Glow<cr>', { desc = 'Markdown Preview (Glow)' })


-- ============================================================================
-- CONFIGURAÇÕES ESPECÍFICAS PARA MARKDOWN
-- ============================================================================

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Spell check em português
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'pt_br,en'
    
    -- Limite de largura visual (não quebra o texto, só indica)
    vim.opt_local.colorcolumn = '80'
    
    -- Conceal (esconde sintaxe markdown para ficar mais limpo)
    vim.opt_local.conceallevel = 2
  end,
})

-- Função para expandir a âncora com número dinâmico

_G.expand_vv = function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]

  -- Texto antes do cursor
  local before_cursor = line:sub(1, col)

  -- Procura vv + números no final
  local num = before_cursor:match("vv(%d+)$")

  if num then
    -- Formata com 3 dígitos
    local padded = string.format("%03d", tonumber(num))

    -- Apaga a palavra anterior (vv + número)
    local term_codes = vim.api.nvim_replace_termcodes("<C-w>", true, false, true)

    -- Texto expandido (cursor ficará após </a>)
    local expansion = string.format(
      '<a name="%s"><sup>%s</sup></a> ',
      padded,
      num
    )

    return term_codes .. expansion
  end

  -- Se não bater o padrão, insere espaço normal
  return " "
end

vim.keymap.set('i', '<Space>', function()
  return _G.expand_vv()
end, { expr = true, silent = true })



    -- Mapeamento local para Enter em blockquotes
-- vim.keymap.set('i', '<CR>', function()
--  local linha = vim.api.nvim_get_current_line()
--  local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
--  local texto_antes = linha:sub(1, cursor_col)
  -- Verifica se a linha atual (antes do cursor) começa com '>'
  -- Ignora espaços iniciais e captura o primeiro caractere não espaço
--  local primeiro_char = texto_antes:match("^%s*(.)")
--    if primeiro_char == '>' then
-- Quebra a linha no ponto atual e insere '> ' na nova linha
--      local enter = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
--      return enter .. '> '
--    else
      -- Comportamento normal do Enter
--      return '<CR>'
--    end
--  end, { buffer = true, expr = true, replace_keycodes = false })


-- ============================================================================
-- MENSAGEM DE BOAS-VINDAS
-- ============================================================================

print("Neovim configurado para Markdown! Use <Space> como tecla líder.")
print("Comandos úteis:")
print("  <Space>ff - Buscar arquivos")
print("  <Space>mp - Preview do Markdown")
print("  <Space>w  - Salvar")


