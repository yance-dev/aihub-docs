在已安装vnc-server的服务器进行操作，没有安装的话联系IT进行安装

启动vnc的命令：

```bash
vncserver -geometry 1920x1080 -rfbport 5901 
```

-rfbport 5902 是指定端口号的命令，为了不与其他同事的端口号冲突，可以在启动前ps -ef|grep vnc看一下其他同事的端口号。

如果不想指定端口号，系统会自动分配端口号：

```yaml
vncserver -geometry 1920x1080
```

如出现以下输出，系统分配的端口是5938

```yaml
Warning: AI-Internal-9960:37 is taken because of /tmp/.X37-lock
Remove this file if there is no X server AI-Internal-9960:37

New 'AI-Internal-9960:38 (xxx)' desktop is AI-Internal-9960:38

Starting applications specified in /home/xxx/.vnc/xstartup
Log file is /home/xxx/.vnc/AI-Internal-9960:38.log
```



启动后即可通过堡垒机vnc访问服务器，选择vnc协议访问，填写端口号和用户名密码，用户名密码填在第一步启动vnc服务的时候设置的用户名密码

![](images/image.png)

第一次进入vnc有时候会出现白屏的情况，出现这种情况，通过ps找到自己开的vnc服务进程号，杀死服务，修改自己home目录下的.vnc/xstartup为如下内容后，再次启动vnc服务即可：

```bash
#!/bin/sh

# Uncomment the following two lines for normal desktop:
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
# exec /etc/X11/xinit/xinitrc

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
#x-window-manager &
#gnome-session &
x-session-manager & xfdesktop & xfce4-panel &
xfce4-menu-plugin &
xfsettingsd &
xfconfd &
xfwm4 &
```

## 注意，如果vnc卡死或异常需要重启vnc时，请先杀死自己的vnc进程再重开。

```yaml
ps -ef|grep vnc|grep xxx(名字小写全拼)
Kill -9 xxx（对应进程号）
```

