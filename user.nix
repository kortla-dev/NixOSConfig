let username = "kortla";
in {
  inherit username;
  name = "Neill Engelbrecht";
  email = "engelbrecht.neill@gmail.com";
  homeDir = "/home/${username}";
  ssh.pubKey =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ0Nwz0rlwT6JTi0Tm9N1BuIXIEokZKFVLOzqTZOuPKb";
}
