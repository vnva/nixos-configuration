{ }:

let vars = import ../../vars;
in {
  enable = true;
  settings = {
    user = {
      name = vars.personal.fullName;
      email = vars.personal.userEmail;
    };

    github.user = vars.personal.github.userName;

    color.ui = true;
    push.default = "current";
    init.defaultBranch = "main";
    core.untrackedCache = true;
    core.sharedRepository = true;

    alias = {
      st = "status -sb";
      co = "checkout";
      br = "branch";
      lg =
        "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };
}
