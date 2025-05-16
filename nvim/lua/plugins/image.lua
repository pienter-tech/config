return {
    {
        "3rd/image.nvim",
        opts = {
            backend = "ueberzug",
            processor = "magick_rock",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    resolve_image_path = function(document_path, image_path, fallback)
                        if string.find(document_path, "Documents/two") then
                            return "/Users/korneel/Library/Mobile Documents/iCloud~md~obsidian/Documents/two/"
                                .. image_path
                        end

                        return fallback(document_path, image_path)
                    end,
                },
            },
            max_width_window_percentage = 30,
            max_height_window_percentage = 30,
        },
    },
}
