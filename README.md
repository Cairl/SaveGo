<h1 align="center">SaveGo</h1>

<p align="center">
<a href="https://github.com/Cairl/SaveGo"><strong>SaveGo</strong></a> 是 <a href="https://github.com/Cairl/SavesGo"><strong>SavesGo</strong></a> 的公测版，实现信息脱敏的同时适配更多操作习惯。<br>项目地址：https://github.com/Cairl/SaveGo
</p>

<br>

## 什么是 SaveGo？

**SaveGo** 是一款基于命令行的批处理工具，旨在快速储存或恢复各类软件、游戏的存档及配置文件。

<br>

## SaveGo 支持的功能

|操作|对象|执行|
|---|---|---|
|`save/load`|**steam** (Steam)|储存/恢复 **Steam** 软件的配置文件。|
|`save/load`|**obs** (Open Broadcaster Software)|储存/恢复 **OBS** 软件的配置文件。|
|`save/load`|**idm** (Internet Download Manager)|储存/恢复 **IDM** 软件的配置文件。|
|`save/load`|**potplayer** (Global PotPlayer)|储存/恢复 **PotPlayer** 软件的配置文件。|
|`save`|**savego** (Compress the SaveGo)|打包压缩 **SaveGo** 文件夹。|
||
|`save/load`|**apex** (Apex Legends)|储存/恢复 **Apex** 游戏的配置文件。|
|`save/load`|**cs2** (Counter-Strike 2)|储存/恢复 **CS2** 游戏的配置文件。|
|`save/load`|**justcase3** (Just Cause 3)|储存/恢复 **Just Cause 3** 游戏的存档及配置文件。|
|`save/load`|**gta4** (Grand Theft Auto IV: Complete Edition)|储存/恢复 **GTA4** 游戏的配置文件。|
|`save/load`|**gta5** (Grand Theft Auto V)|储存/恢复 **GTA5** 游戏的配置文件。|
|`save/load`|**r6vegas** (Rainbow Six: Vegas)|储存/恢复 **Rainbow Six: Vegas** 游戏的存档及配置文件。|
|`save/load`|**r6vegas2** (Rainbow Six: Vegas 2)|储存/恢复 **Rainbow Six: Vegas 2** 游戏的存档及配置文件。|
|`save/load`|**undertale** (Undertale)|储存/恢复 **Undertale** 游戏的存档文件。|
|`save/load`|**nfs9** (Need For Speed: Most Wanted)|储存/恢复 **Need For Speed: Most Wanted** 游戏的存档文件。|
|`save/load`|**dyinglight** (Dying Light)|储存/恢复 **Dying Light** 游戏的配置文件。|
|`save/load`|**titanfall2** (Titanfall 2)|储存/恢复 **Titanfall 2** 游戏的 `client.dll` 文件。|
|`save/load`|**sleepingdogs** (Sleeping Dogs: Definitive Edition)|储存/恢复 **Sleeping Dogs** 游戏的存档及配置文件。|

（程序会自动检测软件或游戏的安装路径，默认以 Steam 版本为准。）

<br>

## 如何使用？

- ### 只需下载 **SaveGo.bat** 文件！

**⚠️注意**：发布在 [**Releases**](https://github.com/Cairl/SaveGo/releases) 页面的可执行文件是包含我个人文件的压缩包，含有解压密码，无法使用。

<br>

- ### 操作方式
请查阅菜单，在命令行中输入**操作指令**以及目标对应的**名称缩写**。

<br>

- ### 语法
指令结构包括两个部分：**`保存/加载` `目标`**

<br>

- ### 举例

|输入|执行|
|---|---|
| `save cs2` | 将`cs2`游戏配置文件保存到当前目录。 |
| `load cs2` | 将`cs2`游戏配置文件恢复到游戏目录。 |

<br>

## 为什么区分 SaveGo 和 ~~SavesGo~~？

~~**SavesGo**~~ 是最初创立的项目，其主要应用范围仅限于我自己。由于其中涉及许多特定环境的操作和敏感信息，因此难以进行公开分发。\
而 **SaveGo** 已经解决上述问题，使得程序能够适应更多的操作可能性。

<br>

### 更名决定

要让 ~~**SavesGo**~~ 具有更多的潜力，它需要的不是一次简单更新，而是一次版本迭代。

起先，程序的主要目标是提供游戏存档相关的储存和恢复服务，而游戏存档文件夹通常被命名为 **Saves**，故而将项目定名 ~~**SavesGo**~~。\
随着版本的更新，软件相关的功能正在逐步实现和完善，如果将程序名称中的 **Saves**（名词）更改为 **Save**（动词）似乎会更符合软件的功能：将各种存档资料保存起来的功用。

因此，在这次版本迭代中，项目将会更名为 **SaveGo**。\
这次更名寓意着 **去除锁定对象带来的局限性，以通用性去匹配更多的可能**。

<p align="right">2024/04/04 Created.</p>
