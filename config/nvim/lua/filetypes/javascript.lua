local M = {}

local util = require "formatter.util"

M.prettierd =  function()
  return {
    exe = "prettierd",
    args = { util.escape_path(util.get_current_buffer_file_path()) },
    stdin = true,
  }
end

return M
