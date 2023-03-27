security.sudo = {
  wheelNeedsPassword = false;
};
# users

  users.extraGroups.vboxusers.members = [ "boski" ];
  # For VR (Simula)
  nix.settings.trusted-users = [ "root" "boski"];
  # USERS
  nix.trustedUsers = [
    "root"
    "boski"
    "oski"
    "vaer"
    "vaernil"
    "ansgar"
    "ansgarus"
    "ansgarius"
    "mortwind"
    "mirra"
    "mirrasotiny"
    "redrhytmic"
  ];

  users.users.boski = {
    isNormalUser = true;
    uid = 1000;
    description = "Ansgar Edgarson";
    extraGroups = [
      "wheel"
      "disk"
      "docker"
      "audio"
      "video"
      "systemd-journal"
      "networkmanager"
      "network"
      "cdrom"
      "vboxusers"
      "corectrl"
      "lp"
      "scanner"
    ];

    ];
    createHome=true;
    # home="/home/boski";
    # home = consts.home;
    # dash vs zsh?
    shell="/run/current-system/sw/bin/bash";
    initialPassword="password";
    openssh.authorizedKeys.keyFiles = [
      "/etc/nixos/ssh/authorized_keys"
      "/home/boski/.ssh/authorized_keys"
      "~/.ssh/authorized_keys"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2dEQrj+8mZVaQHAi4N6DcYK41vTOVEfwsd+dt9VSyF vaernil@gmail.com"
#      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFYFRUEBS2XeaW6sgNhbguZ3500VhdDoiQFUWH0PFkbX nickjanus@janusX1"
    ];
  };
  users.users.root.openssh.authorizedKeys.keys = [
    "my-ssh-pubkey"
  ];
  #users.defaultUserShell = "/run/current-system/sw/bin/fish";
  #users.defaultUserShell = "/run/current-system/sw/bin/zsh";

# services
