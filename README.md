# development-starter

```text
wget -qO- https://raw.githubusercontent.com/yukinakato/development-starter/master/setup.sh | bash
```

### References
#### xrdp configuration
- http://c-nergy.be/blog/?p=12043
- https://c-nergy.be/blog/?p=14051
- https://github.com/neutrinolabs/xrdp/issues/1723#issuecomment-746010514
- https://wiki.archlinux.org/title/GNOME/Keyring#Using_the_keyring
- listen on 127.0.0.1
  ```text
  /etc/xrdp/xrdp.ini
  port=tcp://.:3389
  ```
