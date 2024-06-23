require("obsidian").setup({
  workspaces = {
    {
      name = "Knowledge Vault",
      path = "~/Obsidian/Knowledge Vault 🔐",
    },
  },
    new_notes_location = "notes_subdir",
    disable_frontmatter = true,
    templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
    },
  completion = {
    nvim_cmp = true,
    min_chars = 1,
  },
  ui = {
    checkboxes = { },
    bullets = {  },
  },
})
