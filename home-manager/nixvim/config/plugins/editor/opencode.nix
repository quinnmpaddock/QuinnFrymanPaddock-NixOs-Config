_: {
  plugins.opencode = {
    enable = true;
    settings = {
      lsp.enabled = true;
      reload = true;
    };
  };
  keymaps = [
    # Toggle opencode panel
    {
      mode = [
        "n"
        "t"
      ];
      key = "<leader>ot";
      action.__raw = "require('opencode').toggle";
      options.desc = "OpenCode: Toggle";
    }
    # Ask opencode about current context
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>oa";
      action.__raw = "function() require('opencode').ask('@this: ', { submit = true }) end";
      options.desc = "OpenCode: Ask";
    }
    # Select from opencode prompts/commands
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>os";
      action.__raw = "require('opencode').select";
      options.desc = "OpenCode: Select";
    }
    # Operator: send range to opencode
    {
      mode = "n";
      key = "go";
      action.__raw = "require('opencode').operator('@this ')";
      options = {
        desc = "OpenCode: Add range";
        expr = true;
      };
    }
    # Operator: send line to opencode
    {
      mode = "n";
      key = "goo";
      action.__raw = "require('opencode').operator('@this ') .. '_'";
      options = {
        desc = "OpenCode: Add line";
        expr = true;
      };
    }
    # Scroll opencode up
    {
      mode = "n";
      key = "<leader>ou";
      action.__raw = "function() require('opencode').command('session.half.page.up') end";
      options.desc = "OpenCode: Scroll up";
    }
    # Scroll opencode down
    {
      mode = "n";
      key = "<leader>od";
      action.__raw = "function() require('opencode').command('session.half.page.down') end";
      options.desc = "OpenCode: Scroll down";
    }
    # New session
    {
      mode = "n";
      key = "<leader>on";
      action.__raw = "function() require('opencode').command('session.new') end";
      options.desc = "OpenCode: New session";
    }
    # Interrupt current session
    {
      mode = "n";
      key = "<leader>ox";
      action.__raw = "function() require('opencode').command('session.interrupt') end";
      options.desc = "OpenCode: Interrupt";
    }
  ];
}
