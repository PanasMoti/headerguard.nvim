# headerguard.nvim
a simple header guard generation neovim plugin

## how to use
call ```require("headerguard").setup({})```
inside an empty header file call the function ```:GenerateGuard```

## options
example ```require("headerguard").setup({
    opts.prefix = 'my-prefix'
})```
