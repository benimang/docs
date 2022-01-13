# ios 打包


## 证书管理

### 苹果电脑生成CSR文件

### 网站生成证书文件

### 网站生成mobileprovision

### 证书文件安装到苹果电脑上

### 苹果电脑安装证书


##  打包

### cocosapod配置

`cocosapod` 用来管理项目中用到的库文件，并不是必须要，但是 `GoogleAdmob` 就要用到，系统必须要支持 `Ruby` 环境

- 修改 `/etc/hosts` 否则国内环境无法正常下载
  - <https://www.jianshu.com/p/6ed63cf3b920>
  - <https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com.ipaddress.com%2F>
  - <https://links.jianshu.com/go?to=https%3A%2F%2Ffastly.net.ipaddress.com%2Fgithub.global.ssl.fastly.net%23ipinfo>

### Unity生成Xcode项目

- `Edit` / `Project Settings` / `Player`
    1. `Company Name`
    2. `Product Name`
    3. `Version` 版本显示给用户看，`CFBundleVersion` 好像 `Xcode` 提交的时候可以管理递增
- `icon`
- `splash`

### Xcode项目调整

- `MapFileParser.sh` 文件需要有执行权限 `#!sh chmod 777 MapFileParser.sh`
- 执行 `pod install` 更新第三方库，如果第一次执行可以先执行 `pod setup`，执行完成后会生成一个 `workspace`，打包用的是这个而不是 `Unity` 生成的项目
- `File` / `Project Settings...` 或 `Workspace Settings...` 在 `Build System` 选项选择 `New Build System`
- `Product` / `Scheme` / `Edit Scheme` 将里面 `Debug executabble` 去掉勾选
- `Info.plist` 添加 `NSUserTrackingUsageDescription` 内容可以是 `让您获得更好的广告体验`，使用了广告如果不加这句会导致游戏闪退
- 证书设置 `Unity-iPhone` / `Build Settings` / `Code Signing Identity`
- 证书设置 `Unity-iPhone` / `Signing & Capabilities` / `Provisioning Profile`


## Xcode上传包

1. `Product` / `Archive` 执行会有点慢，如果版本之前已经执行过了，没必要再执行，可以通过直接打开 `Window` / `Organizer`
2. 选择对应的版本，点击 `Distribute App` -> `App Store Conect` -> `Upload` -> 勾选3个选项 -> 选择证书以及 `mobileprovision` -> `Upload`