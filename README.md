# WSL-Desktop-Env

## :question: Purpose

此文件為WSL桌面環境設置教學，使用環境為WSL Ubuntu-22-04。

:bulb:
內涵一些細微優化，有改變電腦底層行為之風險，請自行承擔風險。

## :feet: Step

WSL gnome安裝

1. 使用```win``` + ```r```，輸入cmd打開終端機。
2. 輸入```wsl --install```安裝WSL
3. 等待安裝完成後輸入```sudo apt update && sudo apt -y upgrade```
4. 輸入```sudo vi /etc/wsl.conf```確認以下內容

    ```bash=
    [boot]
    systemd=true
    ```

5. 輸入```sudo systemctl set-default multi-user.target```設定開機啟動模式，可以在首次啟動新的WSL時減少加載延遲。
6. 禁用acpid，避免WSL在安裝gnome時出現錯誤

    ```bash=
    sudo apt install acpid -y
    sudo systemctl disable --now acpid.service acpid.socket acpid.path
    ```

7. 輸入```sudo apt install ubuntu-desktop-minimal -y```此為輕量化gnome安裝，如果想要安裝完整搭載所有app的話可以改成```sudo apt install ubuntu-desktop -y```
8. ```nano ~/gnome.sh``` 貼上以下內容

    ```bash=
    #!/bin/bash
    export XDG_CURRENT_DESKTOP=ubuntu:GNOME
    export XDG_SESSION_DESKTOP=ubuntu
    export DESKTOP_SESSION=ubuntu
    export GNOME_SHELL_SESSION_MODE=ubuntu

    export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
    export XDG_DATA_DIRS=/usr/share/ubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop
    export XDG_MENU_PREFIX=gnome-

    export XDG_SESSION_TYPE=x11
    export XDG_SESSION_CLASS=user
    export GDK_BACKEND=x11

    export LIBGL_ALWAYS_SOFTWARE=1

    export XDG_RUNTIME_DIR=/run/user/$(id -u)

    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

    gnome-session --session=ubuntu
    ```

9. ```chmod +x ~/gnome.sh```
10. 下載X-server <https://sourceforge.net/projects/vcxsrv/>
11. 在桌面執行```git clone https://github.com/fatbrother/WSL-Desktop-Env.git```
12. 在桌面新增捷徑並指向ubuntu.bat，可以將圖案設定成favicon.ico
13. 連點桌面連結打開Ubuntu
14. 輸入```sudo snap remove ubuntu-desktop-installer```移除安裝器
15. 輸入```gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false```隱藏掛載磁碟
16. 如要關閉WSL，回到cmd輸入```ctrl``` + ```c```

-----------------

ZSH安裝

1. 安裝ZSH ```sudo apt install zsh -y```
2. 新增zsh設定檔 ```touch ~/.zshrc && touch ~/.zprofile```
3. 設定ZSH為預設shell ```sudo usermod -s /bin/zsh $USER```
4. 安裝zinit ```bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"```
5. 在gnome裡使用瀏覽器下載以下字體
    [MesloLGS NF Regular.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
    下載後使用檔案管理器打開，點選安裝

6. 輸入```nano ~/.zshrc```，貼上以下內容

    ```bash=
    # zsh 套件四天王
    zinit light zsh-users/zsh-completions
    zinit light zsh-users/zsh-autosuggestions
    zinit light zsh-users/zsh-history-substring-search
    zinit light zdharma-continuum/fast-syntax-highlighting

    # Oh My Zsh 功能
    zinit snippet OMZ::lib/completion.zsh
    zinit snippet OMZ::lib/history.zsh
    zinit snippet OMZ::lib/key-bindings.zsh
    zinit snippet OMZ::lib/theme-and-appearance.zsh

    # key binding
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    bindkey '^I' autosuggest-accept

    # 其他
    zinit load djui/alias-tips

    # powerlevel10k
    zinit ice depth=1
    zinit light romkatv/powerlevel10k
    ```

7. 重開terminal

## :link: Reference

wsl  
<https://learn.microsoft.com/zh-tw/windows/wsl/install#install-wsl-command>  
<https://gist.github.com/Ta180m/e1471413f62e3ed94e72001d42e77e22>  
<https://x410.dev/cookbook/wsl/enable-systemd-in-wsl2-and-have-the-best-ubuntu-gui-desktop-experience/>

zsh  
<https://blog.kyomind.tw/ubuntu-zsh-zinit/>  
<https://blog.kyomind.tw/powerlevel10k/>
