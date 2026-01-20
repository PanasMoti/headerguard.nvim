# headerguard.nvim
a simple header guard generation neovim plugin <br/>
the function generates the following template <br/>
> [!IMPORTANT]
> this is mostly for my personal usesage so bugs maybe plentiful and this may not be updated ever
```
#ifndef __<PREFIX>_<PROJECT_NAME>_<FILE_NAME>__
#define __<PREFIX>_<PROJECT_NAME>_<FILE_NAME>__

#endif // __<PREFIX>_<PROJECT_NAME>_<FILE_NAME>__
```

> [!NOTE]
> ```<PREFIX>``` is what get specified in the plugin setup <br/>
> ```<PROJECT_NAME>``` is the directory the header file is in. *(uses the parent directory if the directory is in ignore_dirs)* <br/>
> ```<FILE_NAME>``` is the name of the header with the extension included *(the .h or .hpp etc)* <br/>

> [!NOTE]
> all letters are converted to upper case <br />
> every '.', '-' and ' ' are replaced with a '_'

> [!WARNING]
> this should only be used on empty files

# Install
- packer:
```
use "PanasMoti/headerguard.nvim"
```

# How To Use 
- call ```require("headerguard").setup({})```
- inside an empty header file call the function ```:GenerateGuard```
> [!TIP] 
> this could also be mapped to a keybind

# Example
```
require("headerguard").setup({
    prefix = 'panasmoti'
    ignore_dirs = { "include", "inc", "source", "src" },
    ignore_dirs_mode = "merge",
})
```

## options
- prefix : the ```<PREFIX>``` constant *(by default it is set to empty)*
```
require("headerguard").setup({
    prefix = 'my-prefix'
})
```
- ignore_dirs : what dirs to ignore when getting the ```<PROJECT_NAME>``` *(list bellow is the default)*
```
require("headerguard").setup({
    ignore_dirs = { "include", "source", "inc", "src" }
})
```
- ignore_dirs_mode : ```"merge"``` or ```"replace"``` the defatult ignore_dirs list *(by default it is set to ```"merge"```)*
```
require("headerguard").setup({
    ignore_dirs = { "include", "source", "inc", "src" },
    ignore_dirs_mode = "merge"
})
```
