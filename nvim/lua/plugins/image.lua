return {
    {
        "3rd/image.nvim",
        enabled = true,
        opts = {
            backend = "kitty",
            processor = "magick_cli",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                },
            },
            max_width_window_percentage = 30,
            max_height_window_percentage = 30,
        },
    },
}
