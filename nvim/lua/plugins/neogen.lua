return {
    "danymat/neogen",
    config = true,
    keys = {
        {
            '<leader>af',
            function ()
                require('neogen').generate({
                    type = 'func'
                })
            end,
            mode = 'n',
            desc = 'Annotate function'
        },
        {
            '<leader>ac',
            function ()
                require('neogen').generate({
                    type = 'func'
                })
            end,
            mode = 'n',
            desc = 'Annotate class'
        },
    }
}
