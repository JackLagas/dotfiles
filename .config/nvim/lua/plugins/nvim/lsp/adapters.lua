return {
    setup = function(dap)
        dap.adapters.lldb = {
            type = "executable",
            command = "/usr/bin/lldb-dap",
            name = "lldb"
        }
        dap.configurations.cpp = {
            {
                name = "Launch",
                type = "codelldb",
                request = "launch",
                program = function()
                    return require('xmake.project').info.target.exec_path
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
            }
        }
    end,
}
