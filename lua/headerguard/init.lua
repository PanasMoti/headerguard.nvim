local M = {}
local prefix = ''
local function replace_dash(str)
    return string.gsub(str, "-", "_")
end

local function replace_dot(str)
    return string.gsub(str, "%.", "_")
end

function M.setup(opts)
    opts = opts or {}
    if opts.prefix then
        prefix = string.upper(replace_dash(replace_dot(opts.prefix)))
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
    local project_name = prefix .. "_" .. string.upper(replace_dash(current_dir))
    local file_name = string.upper(replace_dot(file))
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
