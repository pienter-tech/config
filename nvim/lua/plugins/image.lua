return {
    {
        "3rd/image.nvim",
        enabled = false,
        opts = {
            backend = "ueberzug",
            processor = "magick_rock",
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
