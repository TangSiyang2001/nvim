-- 检测操作系统
local os_type = os.getenv("HOMEBREW_PREFIX") or ""

-- 根据操作系统设置clangd的路径
local clangd_path
if os_type == "/opt/homebrew" then
  -- macOS下使用Homebrew的路径
  clangd_path = "/opt/homebrew/opt/llvm@17/bin/clangd"
else
  -- Linux下使用其他路径
  -- 请将"/path/to/linux/clangd"替换为实际的Linux clangd路径
  clangd_path = "/usr/bin/clangd"
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        clangd = {
          keys = {
            { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          filetypes = {
            "c",
            "cpp",
            "objc",
            "objcpp",
            "cuda",
          },
          cmd = {
            clangd_path,
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--log=verbose",
            "--all-scopes-completion",
            "--cross-file-rename",
            "--header-insertion-decorators",
            "-j=5",
            "--pch-storage=disk",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
        protols = {},
      },
      setup = {
        clangd = function(_, opts)
          local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
          require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
          return false
        end,
      },
    },
  },
}
