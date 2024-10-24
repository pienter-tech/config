vim.api.nvim_create_user_command("Open", function()
    local path = vim.api.nvim_buf_get_name(0)
    vim.notify("Opening buffer in finder...")
    os.execute("open -R '" .. path .. "'")
end, {})
