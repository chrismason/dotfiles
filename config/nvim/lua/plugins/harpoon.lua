return {
    "theprimeagen/harpoon",
    keys = {
        { "<leader>a",  "<cmd>lua require'harpoon.mark'.add_file()<cr>" },
        { "<leader>e",  "<cmd>lua require'harpoon.ui'.toggle_quick_menu()<cr>" },
        { "<leader>tc", "<cmd>lua require'harpoon.cmd-ui'.toggle_quick_menu()<cr>" },
        { "<leader>1",  "<cmd>lua require'harpoon.ui'.nav_file(1)<cr>" },
        { "<leader>2",  "<cmd>lua require'harpoon.ui'.nav_file(2)<cr>" },
        { "<leader>3",  "<cmd>lua require'harpoon.ui'.nav_file(3)<cr>" },
        { "<leader>4",  "<cmd>lua require'harpoon.ui'.nav_file(4)<cr>" },
        { "<leader>5",  "<cmd>lua require'harpoon.ui'.nav_file(5)<cr>" },
        { "<leader>th", "<cmd>lua require'harpoon.term'.gotoTerminal(1)<cr>" },
        { "<leader>tj", "<cmd>lua require'harpoon.term'.gotoTerminal(2)<cr>" },
    },
}
