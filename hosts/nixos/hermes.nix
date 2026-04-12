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
