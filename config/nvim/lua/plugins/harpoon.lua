return {
    "theprimeagen/harpoon",
    keys = {
        { "<leader>a",  "<cmd>lua require'harpoon.mark'.add_file()<cr>" },
        { "<leader>e",  "<cmd>lua require'harpoon.ui'.toggle_quick_menu()<cr>" },
        { "<leader>tc", "<cmd>lua require'harpoon.cmd-ui'.toggle_quick_menu()<cr>" },
        { "<leader>h",  "<cmd>lua require'harpoon.ui'.nav_file(1)<cr>" },
        { "<leader>j",  "<cmd>lua require'harpoon.ui'.nav_file(2)<cr>" },
        { "<leader>k",  "<cmd>lua require'harpoon.ui'.nav_file(3)<cr>" },
        { "<leader>l",  "<cmd>lua require'harpoon.ui'.nav_file(4)<cr>" },
        { "<leader>th", "<cmd>lua require'harpoon.term'.gotoTerminal(1)<cr>" },
        { "<leader>tj", "<cmd>lua require'harpoon.term'.gotoTerminal(2)<cr>" },
    }
}
