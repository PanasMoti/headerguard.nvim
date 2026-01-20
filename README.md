# headerguard.nvim
> [!IMPORTANT]
> this is mostly for my personal usesage so bugs maybe plentiful and this may not be updated ever

a simple header guard generation neovim plugin <br/>
the function generates the following template <br/>
```
#ifndef __<PREFIX>_<PROJECT_NAME>_<FILE_NAME>__
#define __<PREFIX>_<PROJECT_NAME>_<FILE_NAME>__

#endif // __<PREFIX>_<PROJECT_NAME>_<FILE_NAME>__
```

> [!NOTE]
> ```<PREFIX>``` is what get specified in the plugin setup
> ```<PROJECT_NAME>``` is the directory the header file is in. *(uses the root directory if the directory is in ignore_dirs)* 
> ```<FILE_NAME>``` is the name of the header with the extension included *(the .h or .hpp etc)*

> [!NOTE]
> every '.', '-' and ' ' are replaced with a '_'

## how to use
- call ```require("headerguard").setup({})```
- inside an empty header file call the function ```:GenerateGuard```
> [!TIP] 
> this could also be mapped to a keybind

## options
- prefix : the ```<PREFIX>``` constant *(by default it is set to empty)*
```
require("headerguard").setup({
    opts.prefix = 'my-prefix'
})
```
- ignore_dirs : what dirs to ignore when getting the ```<PROJECT_NAME>``` *(list bellow is the default)*
```
require("headerguard").setup({
    opts.ignore_dirs = { "include", "source", "inc", "src" }
})
```
- ignore_dirs_mode : ```"merge"``` or ```"replace"``` the defatult ignore_dirs list *(by default it is set to ```"merge"```)*
```
require("headerguard").setup({
    opts.ignore_dirs = { "include", "source", "inc", "src" },
    opts.ignore_dirs_mode = "merge"
})
```
