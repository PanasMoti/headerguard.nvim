# headerguard.nvim
a simple header guard generation neovim plugin <br/>
the function generates the following template <br/>
```
#ifndef __<PREFIX>_<PROJECT_NAME>_<FILE_NAME>__
#define __<PREFIX>_<PROJECT_NAME>_<FILE_NAME>__

#endif // __<PREFIX>_<PROJECT_NAME>_<FILE_NAME>__
```
## what is what
- ```<PREFIX>``` is what get specified in the plugin setup
- ```<PROJECT_NAME>``` is the directory the header file is in. if the directory is named "include", "inc", "source", "src" it uses the root directory of that 
- ```<FILE_NAME>``` is the name of the header with the extension included (the .h or .hpp etc)

## notes
- every '.', '-' and ' ' are replaced with a '_'

## how to use
call ```require("headerguard").setup({})```
and then inside an empty header file call the function ```:GenerateGuard```

## options
- prefix : the ```<PREFIX>``` constant 
```
require("headerguard").setup({
    opts.prefix = 'my-prefix'
})
```
- ignore_dirs : what dirs to ignore when getting the ```<PROJECT_NAME>```
```
require("headerguard").setup({
    opts.ignore_dirs = { "include", "source", "inc", "src" }
})
```
- ignore_dirs_mode : ```"merge" | "replace"``` by default it is set to ```"merge"```
```
require("headerguard").setup({
    opts.ignore_dirs = { "include", "source", "inc", "src" },
    opts.ignore_dirs_mode = "merge"
})
```
