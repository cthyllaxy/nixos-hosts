{
  programs.alacritty = {
    enable = true;

    settings = {
      window.padding = {
        x = 3;
        y = 3;
      };
      window.opacity = 0.9;

      font = {
        size = 11;
        normal = {
          family = "JetBrainsMono NF";
          style = "Regular";
        };
      };
    };
  };
}
