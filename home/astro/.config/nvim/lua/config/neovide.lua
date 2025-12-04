if vim.g.neovide then
  -- fix the crappy cursory animation
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  -- vim.g.neovide_position_animation_length = 0.0025
  vim.g.neovide_scroll_animation_far_lines = 1
  vim.g.neovide_scroll_animation_length = 0.1

  vim.g.neovide_opacity = 0.85
  vim.g.normal_opacity = 0.8
  vim.g.neovide_show_border = true
  vim.g.neovde_window_blurred = true

  vim.g.neovide_background_color = "#272B43"

  vim.o.guifont = "JetBrainsMono Nerd Font:h10"

  vim.api.nvim_set_keymap("n", "<F11>", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", {})
end
