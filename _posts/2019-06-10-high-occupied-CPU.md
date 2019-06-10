---
layout:     post
title:      cron guard service
subtitle:   来自root 的进程对 CPU占用高解决方法
date:       2019-06-10
author:     Lin
header-img: img/seaside-huizhou.jpg
catalog: true
tags:
    - cron
    - architecture
    - service
---
# 前言

> Hi everyone, Here I will fix the **High occupied CPU** problem.

> 有时候，CPU 占用很高，而且是root的进程。比如 `top`

```
Tasks: 558 total,   1 running, 557 sleeping,   0 stopped,   0 zombie
%Cpu(s): 61.4 us,  0.0 sy,  0.0 ni, 38.6 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem : 13191446+total, 10841356+free,  3224532 used, 20276364 buff/cache
KiB Swap: 13409894+total, 13409894+free,        0 used. 12776337+avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND                                                                
 3430 root      20   0   81488  75840      4 S  3588  0.1 406637:57 sd-pam                                                                     
11707 user     20   0   40940   3980   3044 R   6.2  0.0   0:00.02 top                                                                    
    1 root      20   0  119924   6064   3968 S   0.0  0.0   0:11.58 systemd                                                                
    2 root      20   0       0      0      0 S   0.0  0.0   0:00.10 kthreadd
```

这里 root 进程 *sd-pam* 占用了大量CPU资源。如何解决这个问题？

通过 `pstree -p 3430` 我们得到，该进程的完整的进程树是 **systemd---libserv---libserv** 。
通过 `ps -eo pid,comm,unit` 我们 得到 security info ：

```
3430 libserv         cron.service
```
通过 `pa -aux` 我们得到 see every process on the system using BSD syntax：

```
root      1630  0.0  0.0  27728  2916 ?        Ss   Jun02   0:08 /usr/sbin/cron -f
```

我们找到，是`cron` 服务守护着 libserv 进程。这就是sd-pam 始终kill 不了的原因。
接下来的方法就比较简单了。

    sudo kill 1630 
    sudo kill 3430

相似的问题也发生在 `sh`，就是 `top`  列出的 `sh` 命令占用CPU很高，用上述方法可以解决。

参考：
[a strange behavior of sd-pam #11753](https://github.com/systemd/systemd/issues/11753)
[Where is this cron job running from?](https://serverfault.com/questions/103482/where-is-this-cron-job-running-from)
[systemd System and Service Manager](https://www.freedesktop.org/wiki/Software/systemd/)

