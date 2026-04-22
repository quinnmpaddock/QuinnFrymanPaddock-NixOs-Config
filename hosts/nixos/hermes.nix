# /etc/nixos/hosts/nixos/hermes.nix
{
  config,
  ...
}:

{
  sops = {
    defaultSopsFile = ./../../secrets/hermes.yaml;
    age.keyFile = "/home/quinn/.config/sops/age/keys.txt";
    secrets."hermes-env" = {
      format = "yaml";
    };
  };

  services.hermes-agent = {
    enable = true;
    settings = {
      model = {
        default = "opencode-go/glm-5.1";
        provider = "opencode-go";
        base_url = "https://opencode.ai/zen/go/v1";
        api_mode = "chat_completions";
      };

      smart_model_routing = {
        enabled = true;
        max_simple_chars = 160;
        max_simple_words = 28;
        cheap_model = {
          base_url = "http://localhost:11434/v1";
          api_key = "ollama";
          model = "gemma4:e4b";
        };
      };
      terminal = {
        backend = "local";
        timeout = 180;
        cwd = ".";
      };
      memory = {
        provider = "holographic";
        memory_enabled = true;
        user_profile_enabled = true;
      };
    };
    environmentFiles = [ config.sops.secrets."hermes-env".path ];
    addToSystemPackages = true;
    # extraPackages = [
    #
    # ];
  };
}

# { config, ... }:
# {
#   sops = {
#     defaultSopsFile = ./../../secrets/hermes.yaml;
#     age.keyFile = "/home/quinn/.config/sops/age/keys.txt";
#     secrets."hermes-env" = {
#       format = "yaml";
#     };
#   };
#
#   services.hermes-agent = {
#     enable = true;
#     settings = {
#       model = {
#         default = "gemma4:26b";
#         provider = "custom";
#         base_url = "http://localhost:11434/v1";
#         api_key = "ollama";
#         api_mode = "chat_completions";
#       };
#
#       delegation = {
#         base_url = "http://localhost:11434/v1";
#         api_key = "ollama";
#         model = "gemma4:26b";
#         max_iterations = 20;
#         reasoning_effort = "none";
#       };
#
#       auxiliary = {
#         vision = {
#           base_url = "http://localhost:11434/v1";
#           api_key = "ollama";
#           model = "gemma4:e4b";
#           timeout = 120;
#         };
#         web_extract = {
#           base_url = "http://localhost:11434/v1";
#           api_key = "ollama";
#           model = "gemma4:e4b";
#           timeout = 360;
#         };
#         compression = {
#           base_url = "http://localhost:11434/v1";
#           api_key = "ollama";
#           model = "gemma4:e4b";
#           timeout = 120;
#         };
#         session_search = {
#           base_url = "http://localhost:11434/v1";
#           api_key = "ollama";
#           model = "gemma4:e4b";
#         };
#         skills_hub = {
#           base_url = "http://localhost:11434/v1";
#           api_key = "ollama";
#           model = "gemma4:e4b";
#         };
#         approval = {
#           base_url = "http://localhost:11434/v1";
#           api_key = "ollama";
#           model = "gemma4:e4b";
#         };
#         mcp = {
#           base_url = "http://localhost:11434/v1";
#           api_key = "ollama";
#           model = "gemma4:e4b";
#         };
#         flush_memories = {
#           base_url = "http://localhost:11434/v1";
#           api_key = "ollama";
#           model = "gemma4:e4b";
#         };
#       };
#
#       smart_model_routing = {
#         enabled = true;
#         max_simple_chars = 160;
#         max_simple_words = 28;
#         cheap_model = {
#           base_url = "http://localhost:11434/v1";
#           api_key = "ollama";
#           model = "gemma4:e4b";
#         };
#       };
#
#       terminal = {
#         backend = "local";
#         timeout = 180;
#         cwd = ".";
#       };
#       memory = {
#         provider = "holographic";
#         memory_enabled = true;
#         user_profile_enabled = true;
#       };
#       compression = {
#         enabled = true;
#         threshold = 0.6;
#       };
#     };
#     environmentFiles = [ config.sops.secrets."hermes-env".path ];
#     addToSystemPackages = true;
#   };
# }
