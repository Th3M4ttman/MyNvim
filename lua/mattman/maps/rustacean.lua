



return {
	{ "<leader>R", group = "Rust" },
	{ "<leader>Rr", "<cmd>RustLsp runnables<cr>", desc = "Run" },
    { "<leader>Rt", "<cmd>RustLsp testables<cr>",       desc = "Test" },
    { "<leader>Rc", "<cmd>RustLsp openCargo<cr>",      desc = "Cargo" },
    { "<leader>Re", "<cmd>RustLsp renderDiagnostic<cr>",    desc = "Render Diagnostic" },
    { "<leader>RE", "<cmd>RustLsp relatedDiagnostics<cr>",        desc = "Related Diagnostic" },
    { "<leader>Ro", "<cmd>RustLsp openDocs<cr>",        desc = "Open Docs" },
    { "<leader>Rm", "<cmd>RustLsp expandMacro<cr>",    desc = "Expand Macro" },
    { "<leader>Rh", "<cmd>RustLsp hoverActions<cr>",   desc = "Hover Actions" },
    { "<leader>Rj", "<cmd>RustLsp joinLines<cr>",      desc = "Join Lines" },
    { "<leader>Rk", "<cmd>RustLsp moveItem Up<cr>",     desc = "Move Item Up" },
    { "<leader>Rl", "<cmd>RustLsp moveItem Down<cr>",   desc = "Move Item Down" },
}




