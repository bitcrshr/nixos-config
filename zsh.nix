{
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;

  shellAliases = {
    update = "sudo nixos-rebuild switch";
    conedit = "sudo hx /etc/nixos";
  };

  oh-my-zsh = {
    enable = true;
    plugins = [ "git" ];
    theme = "robbyrussell";
  };
}
