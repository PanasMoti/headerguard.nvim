local M = {}
local prefix = ''
local function replace_dash(str)
    return string.gsub(str, "-", "_")
end

local function replace_dot(str)
    return string.gsub(str, "%.", "_")
end

local function replace_space(str)
    return string.gsub(str, " ", "_")
end

local function fmt_string(str)
    return string.upper(replace_dash(replace_dot(replace_space(str))))
end

function M.setup(opts)
    opts = opts or {}
    if opts.prefix then
        prefix = fmt_string(opts.prefix) .. "_"
    end
    vim.api.nvim_create_user_command(
        "GenerateGuard",
        function()
            M.GenerateGuard()
        end,
        { desc = "Generate a C/C++ header guard" }
    )
end
function M.GenerateGuard()
    local file = vim.fn.expand("%:t")
    local ignore = { inc = true, include = true, src = true, source = true }
    local current_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    if ignore[current_dir] then
        current_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":h:t")
    end
    print(prefix)
    local project_name = prefix .. fmt_string(current_dir) 
    local file_name = fmt_string(file)
    local macro = "__" .. project_name .. "_" .. file_name .. "__"
    local lines = {
        "#ifndef " .. macro,
        "#define " .. macro,
        "",
        "#endif // " .. macro,
    }
    vim.api.nvim_buf_set_lines(0, vim.fn.line(".") - 1, vim.fn.line("."), false, lines)
    vim.api.nvim_win_set_cursor(0, { vim.fn.line(".") + 2, 0 })
end

return M
