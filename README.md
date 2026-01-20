# headerguard.nvim
a simple header guard generation neovim plugin <br/>
the function generates the following template <br/>
```
#ifndef __<PREFIX>_<PROJECT NAME>_<FILE NAME>__
#define __<PREFIX>_<PROJECT NAME>_<FILE NAME>__

#endif // __<PREFIX>_<PROJECT NAME>_<FILE NAME>__
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
- prefix ```require("headerguard").setup({
    opts.prefix = 'my-prefix'
})```

