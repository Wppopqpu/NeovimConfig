return {
	{
		"yetone/avante.nvim",
		-- 如果您想从源代码构建，请执行 `make BUILD_FROM_SOURCE=true`
		-- ⚠️ 一定要加上这一行配置！！！！！
		-- build = vim.fn.has("win32") ~= 0
		-- and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		-- or "make",
		build = "make BUILD_FROM_SOURCE=true",
		event = "VeryLazy",
		version = false, -- 永远不要将此值设置为 "*"！永远不要！
		---@module 'avante'
		---@type avante.Config
		opts = {
			provider = "openai",
			auto_suggestions_provider = "openai",
			providers = {
				-- openai = {
				-- 	-- endpoint = "https://qianfan.baidubce.com/v2/chat/completions",
				-- 	endpoint = "https://qianfan.baidubce.com/v2",
				-- 	model = "deepseek-v3.2-think",
				-- 	api_key_name = "OPENAI_API_KEY",
				-- 	max_tokens = 4096,
				-- },
				openai = {
					endpoint = "https://integrate.api.nvidia.com/v1",
					model = "moonshotai/kimi-k2-instruct",
					api_key_name = "OPENAI_API_KEY",
					extra_request_body = {
						temperature = 0.6,
					},
				},
			},
		},
		init = function ()
			local api_key_path = "/home/branch/documents/important/default_api_key"
			local file = io.open(api_key_path, "r")
			if not file then
				return
			end
			vim.env.OPENAI_API_KEY = file:read()
			file:close()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- 以下依赖项是可选的，
			-- "echasnovski/mini.pick", -- 用于文件选择器提供者 mini.pick
			"nvim-telescope/telescope.nvim", -- 用于文件选择器提供者 telescope
			-- "hrsh7th/nvim-cmp", -- avante 命令和提及的自动完成
			"ibhagwan/fzf-lua", -- 用于文件选择器提供者 fzf
			"nvim-tree/nvim-web-devicons", -- 或 echasnovski/mini.icons
			-- "zbirenbaum/copilot.lua", -- 用于 providers='copilot'
			{
				-- 支持图像粘贴
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- 推荐设置
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- Windows 用户必需
						use_absolute_path = true,
					},
				},
			},
			-- placed in coding.lua
			-- {
			-- 	-- 如果您有 lazy=true，请确保正确设置
			-- 	'MeanderingProgrammer/render-markdown.nvim',
			-- 	opts = {
			-- 		file_types = { "markdown", "Avante" },
			-- 	},
			-- 	ft = { "markdown", "Avante" },
			-- },
		},
	}
}
