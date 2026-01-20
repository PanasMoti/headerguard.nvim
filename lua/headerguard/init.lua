local M = {}
local config = {
    prefix = '',
    ignore_dirs = {
        inc = true,
        include = true,
        src = true,
        source = true,
    },
    ignore_dirs_mode = "merge", -- "merge" | "replace" 
}
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
local function apply_ignore_dirs(user_dirs, mode)
    if not user_dirs then
        return
    end

    if mode == "replace" then
        config.ignore_dirs = {}

        -- normalize list or map
        if vim.islist(user_dirs) then
            for _, dir in ipairs(user_dirs) do
                config.ignore_dirs[dir] = true
            end
        else
            for dir, value in pairs(user_dirs) do
                config.ignore_dirs[dir] = value
            end
        end

    else -- merge (default)
        if vim.islist(user_dirs) then
            for _, dir in ipairs(user_dirs) do
                config.ignore_dirs[dir] = true
            end
        else
            for dir, value in pairs(user_dirs) do
                config.ignore_dirs[dir] = value
            end
        end
    end
end
function M.setup(opts)
    opts = opts or {}
    if opts.prefix then
        config.prefix = fmt_string(opts.prefix) .. "_"
    end
    if opts.ignore_dirs_mode then
        config.ignore_dirs_mode = opts.ignore_dirs_mode
    end
    if opts.ignore_dirs_mode
        and opts.ignore_dirs_mode ~= "merge"
        and opts.ignore_dirs_mode ~= "replace" then
        vim.notify(
            "headerguard: ignore_dirs_mode must be 'merge' or 'replace'",
            vim.log.levels.ERROR
        )
        return
    end
    apply_ignore_dirs(opts.ignore_dirs, config.ignore_dirs_mode)
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
    local ignore = config.ignore_dirs

    local bufname = vim.api.nvim_buf_get_name(0)
    local current_dir = vim.fn.fnamemodify(bufname, ":p:h:t")

    if ignore[current_dir] then
        current_dir = vim.fn.fnamemodify(bufname, ":p:h:h:t")
    end
    local project_name = config.prefix .. fmt_string(current_dir) 
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
