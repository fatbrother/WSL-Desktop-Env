# WSL設定

:::info
:bulb:
本文內涵一些細微優化，有改變電腦底層行為之風險，請自行承擔風險。
:::

## :question: Purpose

此文件為WSL桌面環境設置教學，使用環境為WSL Ubuntu-20.04，如有任何問題歡迎留言詢問。

## :feet: Step

1. 使用```win``` + ```r```，輸入cmd打開終端機。
2. 輸入```wsl --install -d Ubuntu-20.04```
3. 等待安裝完成後輸入```sudo apt update && sudo apt -y upgrade```
4. 輸入```sudo apt install ubuntu-desktop-minimal -y```此為輕量化gnome安裝，如果想要安裝完整搭載所有app的話可以改成```sudo apt install ubuntu-desktop -y```
5. ```nano ~/gnome.sh``` 貼上以下
```bash=
#!/bin/bash
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0;
export XDG_SESSION_TYPE="x11"
export XDG_RUNTIME_DIR=~/.cache/xdg
export XDG_SESSION_CLASS="user"
export XDG_SESSION_DESKTOP=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export DESKTOP_SESSION=ubuntu
export GDMSESSION=ubuntu
export GNOME_SHELL_SESSION_MODE=ubuntu
export LIBGL_ALWAYS_SOFTWARE=1
gnome-session "$@"
```
6. ```cmod +x ~/gnome.sh```
7. 下載X-server https://sourceforge.net/projects/vcxsrv/
8. 在桌面執行```git clone https://github.com/fatbrother/WSL-Desktop-Env.git```
9. 在桌面新增捷徑並指向ubuntu.bat，可以將圖案設定成favicon.ico
10. 連點桌面連結打開Ubuntu

## :link: Reference
https://learn.microsoft.com/zh-tw/windows/wsl/install#install-wsl-command  
https://gist.github.com/Ta180m/e1471413f62e3ed94e72001d42e77e22  
https://x410.dev/cookbook/wsl/enable-systemd-in-wsl2-and-have-the-best-ubuntu-gui-desktop-experience/