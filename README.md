# package__sh
自动化打包 打多个 可替换icon 启动图 额外资源


Then, run the following command:

```bash
$ sh cp_31.sh
```
可配置参数
```bash
#!/bin/bash
#只需要在终端中输入 $ sh cp_31.sh + 配置文件地址. 即可打包成ipa
#配置文件目录结构
#            |-图标  |-xxx
#             |-...
#            |-ExportOptions.plist
#            |-archive


#工程名
project_name='LotteryShop'
#工程地址
project_path='/Users/gwh/mine/svn/ltshop_trunk/root/LotteryShopWithoutLL'
#31个图标启动图等存放位置 里面是app名字的文件夹 文件夹里放图标 启动图 和额外替换的图
#注意工程中的icon 使用Images.xcassets/AppIcon.appiconset
#launch使用Images.xcassets/LaunchImage.launchimage
resource_path='/Users/gwh/mine/打包/打包素材/图标'
#ipa生成路径
#在此新建一个空文件夹archive
output_path='/Users/gwh/mine/打包/打包素材'
#xcarchive临时存放路径
archive_path="$output_path/archive"

#打1个试一下all=0 还是全部all=1
all=0

#app的名字 CFBundleDisplayName CFBundleName
appNames=(白鹭巷体彩店 必胜体彩店)

#app bid前缀
bidPrefix="czlm.LotteryShop."
#app bid后缀
appIds=(bailuxiang bishen)

#ExportOptions 用xcode打包一次可生成

#要替换的icons素材
icons=(AppIcon40x40@2x.png AppIcon40x40@3x.png AppIcon60x60@2x.png AppIcon60x60@3x.png)
launchs=(LaunchImage-700-568h@2x.png LaunchImage-700@2x.png LaunchImage-800-667h@2x.png LaunchImage-800-Portrait-736h@3x.png)

#素材文件夹中额外要替换的资源名
#要替换的工程中的资源路径
changeNames=(AppIcon60x60@3x.png dongfanghong_login_back.png)
changeNamesInProj=(pic/熊猫体育/app_icon.png pic/熊猫体育/app_login_back.png)
```
