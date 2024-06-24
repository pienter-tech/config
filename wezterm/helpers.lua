local Helpers = {}

function Helpers.is_vim(pane)
    return pane:get_user_vars().IS_NVIM == 'true'
end

return Helpers
