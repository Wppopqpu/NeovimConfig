local M = {}

M.config = detail("float_mod.config")

M.setup = M.config.setup

detail("float_mod.blend")
detail("float_mod.shadow")

return M
