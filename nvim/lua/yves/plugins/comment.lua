return {
  'numToStr/Comment.nvim',
  lazy = false,
  config = function ()
    -- We run setup to create the keymap
    require('Comment').setup()
  end
}
