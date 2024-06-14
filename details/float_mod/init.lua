local M = {}

M.config = require("NeovimConfig.details.float_mod.config")

M.setup = M.config.setup

require("NeovimConfig.details.float_mod.blend")

return M
