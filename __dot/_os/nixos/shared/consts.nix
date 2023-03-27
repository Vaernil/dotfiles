rec {
  #email    = "vaernil@gmail.com";
  #name     = "Ansgar Edgarson";
  email    = "";
  name     = "";
  name1    = "80sk1 Oski";
  name2    = "Oskar Edgar Olejniczak";
  #g.email  = "${email}";
  guser    = "Vaernil";

  user     = "boski";
  #home     = "/home/${user}";
  #dotfiles = "${home}/_dotfiles";

  sshKeys  = [
               "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDqmxvqjQFl2R0TB+IOSpe64mmvvHFlL/3TJuWyC77OIuUp1ZTEIJn0O+LHCQCvO5jYNkpHGrzTB2zQ2TQUT4RVltAEWu1o6kp0TB1MmEKyUAaYaOql5fMlRwrSjk59PB1NbRfyYKG1/osv3ovxZAd655zbeJDBGoIKx0KgWGcst27qSxhlBOIn5tIE26bAJQM4B33y/k1/RmyfPUMyIcWnVNbaEF6q/OdCN1E3s2hkNdtIS6oLh4qjqr5oJoy5WP5aiVbPHU02qHCcuJ5ZVsCeRtgSIGl5OF69fcgelVLsIiwCgqoxXBaG/OkqpCu2cxDd4LoxIATdgnFvTxICncb/FXWXilfBM8WuI0bR9nvIhUhxMnynASGRXmE6I9aWxT2uMSRh+BP1it/kfpSypEOsUeXHvAZFXpN3CXzOfHoIUZkNsg5W6O4m+9eOegAjvv7RKpqRtGHj69rlZEto7W84YffOhmG5lcluY/V1bT2UW2HMYnRZg7EcY0snipm6Hh8= boski@pc-nixos"

               "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2dEQrj+8mZVaQHAi4N6DcYK41vTOVEfwsd+dt9VSyF vaernil@gmail.com"
             ];

  gpgKeys  = {
    signing = "";
  };

  syncthingDevices = {
    pc-i9-nixos = {
      id = "";
    };

    s-dell-r710 = {
      id = "";
    };

    #trouw.id = "NGZND66-ZLQFRIH-M6W77CS-FTHYQWT-EGYGD6S-V6MGTS2-K7JUCWC-W4DTTAL";

    phone = {
      # id = "";
      introducer = true;
    };
  };
}
