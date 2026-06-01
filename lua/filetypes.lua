vim.filetype.add({
    extension = {
        jinja = 'jinja',
        jinja2 = 'jinja',
        j2 = 'jinja',
    },
    pattern = {
        -- Matches HTML files with Jinja variables inside them
        ['.*%.html%.jinja'] = 'html.jinja',
        ['.*%.html%.j2'] = 'html.jinja',
    },
})
