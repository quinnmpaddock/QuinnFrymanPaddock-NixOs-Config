{ pkgs, ... }:

{
  plugins = {
    neotest = {
      enable = true;
      adapters = {
        # add language adapters for neotest here:
        python.enable = true;
      };
    };
    dap = {
      enable = true;
      signs = {
        dapBreakpoint = {
          text = "●";
          texthl = "DapBreakpoint";
        };
        dapBreakpointCondition = {
          text = "";
          texthl = "DapBreakpointCondition";
        };
        dapBreakpointRejected = {
          text = "󰱩";
          texthl = "DiagnosticError";
        };
        dapLogPoint = {
          text = "";
          texthl = "DiagnosticInfo";
        };
        dapStopped = {
          text = "";
          texthl = "DiffChange";
        };
      };
    };
    dap-ui = {
      enable = true;
      # add ui config options here:
    };
    dap-virtual-text.enable = true;
    dap-python = {
      enable = true;

    };
  };
  extraPlugins = with pkgs.vimPlugins; [
    nvim-nio
  ];
}
