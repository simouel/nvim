local dap = require('dap')
require("dap-python").setup("python", {})
--dap.adapters.python = {
--  type = 'executable';
--  command = '/home/souellet/src/.virtualenvs/debugpy/bin/python';
--  args = { '-m', 'debugpy.adapter' };
--}
--dap.adapters.remote_python = function(callback)
--  local host = 'localhost'
--  callback({
--    type = 'server';
--    host = host;
--    port = 5678;
--  })
--end

dap.set_log_level('TRACE')
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
  {
      type = 'remote_python',
      name = 'Generic remote',
      request = 'attach',
      host = 'localhost',
      port = 5678,
      pathMappings = {{
        -- Update this as needed
        localRoot = vim.fn.getcwd();
        remoteRoot = "/code/";
      }};
  },
  {
      type = 'python',
      name = 'Container',
      request = 'attach',
      host = 'localhost',
      port = 5678,
      mode = "remote",
      pathMappings = {{
        -- Update this as needed
        localRoot = vim.fn.getcwd();
        remoteRoot = "/code/";
      }};
  }
}

dap.adapters.php = {
    type = 'executable',
    command = 'node',
    args = {"/home/souellet/src/vscode-php-debug.git/out/phpDebug.js"},
}

dap.configurations.php = {
    {
        type = 'php',
        request = 'launch',
        name = 'Listen for xdebug',
        port = '9003',
        log = true,
        serverSourceRoot = '/var/www/',
        localSourceRoot = vim.fn['getcwd'](),

    },
}
--table.insert(require('dap').configurations.python, {
--  type = 'python',
--  request = 'launch',
--  name = 'My custom launch configuration',
--  program = '${file}',
--  -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
--})
