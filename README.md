# development-starter

## WSL

```text
wget -qO- https://raw.githubusercontent.com/yukinakato/development-starter/master/setup_wsl.sh | bash
```

## Ubuntu

```text
wget -qO- https://raw.githubusercontent.com/yukinakato/development-starter/master/setup.sh | bash
```

## Remote Desktop into WSL

```sh
sudo apt -y install xrdp xfce4
echo xfce4-session > ~/.xsession
```

Edit `/etc/xrdp/xrdp.ini` to change port.

```sh
sudo service xrdp start
```

## References

### Git Credential Management on WSL

<https://github.com/GitCredentialManager/git-credential-manager/blob/main/docs/wsl.md>

### xrdp configuration

- <https://c-nergy.be/blog/?p=12043>
- <https://c-nergy.be/blog/?p=14051>
- <https://github.com/neutrinolabs/xrdp/issues/1723#issuecomment-746010514>
- <https://wiki.archlinux.org/title/GNOME/Keyring#Using_the_keyring>
- listen on 127.0.0.1

  ```text
  /etc/xrdp/xrdp.ini
  port=tcp://.:3389
  ```
