<h1 align="center">SaveGo</h1>

<p align="center">
  [**SaveGo**](https://github.com/Cairl/SaveGo) 是 [**SavesGo**](https://github.com/Cairl/SavesGo) 的公测版，实现信息脱敏的同时适配更多操作习惯。
  项目地址：https://github.com/Cairl/SaveGo
</p>



## 什么是 SaveGo？

**SaveGo** 是一款基于命令行的批处理工具，旨在快速储存或恢复各类软件、游戏的存档及配置文件。

## 如何使用？

### 你只需下载 **SaveGo.bat** 文件！

（发布在 [**Releases**](https://github.com/Cairl/SaveGo/releases) 页面的可执行文件是包含我个人文件的压缩包，含有解压密码。）

### 操作方式
请参考菜单，在命令行中输入指令和对应目标名称的缩写。

### 语法
指令分为两个结构（无关大小写）：`save/load` `目标`

### 举例

|输入|执行|
|---|---|
| `save cs2` | 将`cs2`游戏配置文件保存到当前目录。 |
| `load cs2` | 将`cs2`游戏配置文件恢复到游戏目录。 |

## 为什么需要区分 SaveGo 和 SavesGo？

**SavesGo** 是先于 **SaveGo** 创立的项目，不过主要应用对象局限于我自己。由于其中包含很多特定环境的操作和敏感信息，难以公开分发。而 **SaveGo** 已解决上述问题，使程序能够适应更多操作可能性。

要想让 **SavesGo** 拥有更多的可能性，所需要的不是一版更新，而是一次版本迭代。

### 为什么将名称中的"Saves"改为"Save"？

在最初阶段，程序的主要目标是提供针对游戏存档的储存及恢复服务，而游戏存档文件夹通常都会被命名为"Saves"，故取名"Save**s**Go"。\
随着程序的更新，软件相关的功能也在逐步实现、完善，这时候把程序名称中的"Saves"（名词）更换为"Save"（动词）似乎更加贴切。

因此，在这次版本迭代过程中，项目得以更名"SaveGo"。

2024/04/04
