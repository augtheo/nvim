local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  return
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

--  Setup constants
local WORKSPACE_PATH = "/tmp" .. "/.workspace/"
local CONFIG = "linux"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local JAVA_DAP_ACTIVE = true

local bundles = {}

if JAVA_DAP_ACTIVE then
  vim.list_extend(
    bundles,
    vim.fn.glob("$MASON/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true, true)
  )
  vim.list_extend(bundles, vim.fn.glob("$MASON/packages/java-test/extension/server/*.jar", true, true))
end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. vim.fn.expand "$MASON/packages/jdtls/lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob "$MASON/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
    "-configuration",
    vim.fn.expand "$MASON/packages/jdtls/config_" .. CONFIG,
    "-data",
    workspace_dir,
  },
  capabilities = capabilities,
  root_dir = root_dir,
  settings = {
    java = {
      -- jdt = {
      --   ls = {
      --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
      --   }
      -- },
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-11",
            path = "~/.sdkman/candidates/java/11.0.12-open",
          },
          {
            name = "JavaSE-17",
            path = "~/.sdkman/candidates/java/17.0.6-tem",
          },
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all", -- literals, all, none
        },
      },
      format = {
        enabled = false,
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    bundles = bundles,
  },
  on_attach = function(client, bufnr)
    vim.lsp.codelens.refresh()
    client.server_capabilities.documentFormattingProvider = false
    require("jdtls").setup_dap { hotcodereplace = "auto" }
    require("user.lsp.handlers").on_attach(client, bufnr)

    local opts = function(description)
      return { noremap = true, silent = true, desc = description, buffer = bufnr }
    end
    -- stylua: ignore start
    local keymap = vim.keymap.set
    keymap("n", "<leader>lo", "<Cmd>lua require'jdtls'.organize_imports()<CR>",            opts "Organize Imports")
    keymap("n", "<leader>lv", "<Cmd>lua require('jdtls').extract_variable()<CR>",          opts "Extract Variable")
    keymap("n", "<leader>lc", "<Cmd>lua require('jdtls').extract_constant()<CR>",          opts "Extract Constant")
    keymap("n", "<leader>lt", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>",         opts "Test Method")
    keymap("n", "<leader>lT", "<Cmd>lua require'jdtls'.test_class()<CR>",                  opts "Test Class")
    keymap("n", "<leader>lu", "<Cmd>JdtUpdateConfig<CR>",                                  opts "Update Config")

    keymap("v", "<leader>lv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts "Extract Variable")
    keymap("v", "<leader>lc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts "Extract Constant")
    keymap("v", "<leader>lm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",   opts "Extract Method")
    -- stylua: ignore end

    require("jdtls.dap").setup_dap_main_class_configs()
  end,
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    vim.lsp.codelens.refresh()
  end,
})
jdtls.start_or_attach(config)

vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

-- linting
require("sonarlint").setup {
  server = {
    cmd = {
      "sonarlint-language-server",
      -- Ensure that sonarlint-language-server uses stdio channel
      "-stdio",
      "-analyzers",
      -- paths to the analyzers you need, using those for python and java in this example
      -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
      -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
      vim.fn.expand "$MASON/share/sonarlint-analyzers/sonarjava.jar",
    },
  },
  filetypes = {
    -- Tested and working
    -- 'python',
    -- 'cpp',
    -- Requires nvim-jdtls, otherwise an error message will be printed
    "java",
  },
}
