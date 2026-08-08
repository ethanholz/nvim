return {
    cmd = { "tombi", "lsp" },
    filetypes = { "toml" },
    root_markers = { "tombi.toml", "pyproject.toml", "pixi.toml", ".git" },
    settings = {
        tombi = {
            schemas = {
                {
                    path = "https://pixi.sh/v0.76.1/schema/manifest/schema.json",
                    include = "**/pixi.toml",
                },
            },
        },
    },
}
