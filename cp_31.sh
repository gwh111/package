 #!/bin/bash
#只需要在终端中输入 $ sh cp_31.sh + 配置文件地址. 即可打包成ipa
#配置文件目录结构
#			|-图标  |-xxx
#             |-...
#			|-ExportOptions.plist
#			|-archive


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

#下面不用配置了
appName='xx'
appId='xx'

packaging(){

#***********配置项目
MWConfiguration=Debug
#日期
MWDate=`date +%Y%m%d_%H%M`

#pod 相关配置

#更新pod配置
# pod install

#构建
xcodebuild archive \
-workspace "$project_path/$project_name.xcworkspace" \
-scheme "$project_name" \
-configuration "$MWConfiguration" \
-archivePath "$archive_path/$project_name" \
clean \
build \
-derivedDataPath "$MWBuildTempDir"

#生成ipa
xcodebuild -exportArchive -exportOptionsPlist "$output_path/ExportOptions.plist" -archivePath "$archive_path/$project_name.xcarchive" -exportPath $output_path/$appId

#########这里不需要也可以去掉#########
#移动重命名
mv /$output_path/$appId/LotteryShop.ipa /$output_path/$appId.ipa
#删除
rm -r $output_path/$appId/
#########这里不需要也可以去掉#########


}


#---------------------------------------------------------------------------------------------------------------------------------
prepare(){

plist_path="${project_path}/${project_name}/Info.plist"
echo $plist_path

#替换displayName以及bundleId
sed -i '' "/CFBundleDisplayName/{n;s/<string>.*<\/string>/<string>$appName<\/string>/;}" $plist_path
sed -i '' "/CFBundleName/{n;s/<string>.*<\/string>/<string>$appName<\/string>/;}" $plist_path
sed -i '' "/CFBundleIdentifier/{n;s/<string>.*<\/string>/<string>czlm.LotteryShop.$appId<\/string>/;}" $plist_path

m=0
while [[ m -lt ${#icons[@]} ]]; do
    icon=${icons[m]}
    launch=${launchs[m]}
    echo "${icon}"
    echo "${launch}"
    let m++

    #替换图标、启动图
    cp "${resource_path}/${appName}/${icon}" "${project_path}/${project_name}/Images.xcassets/AppIcon.appiconset/${icon}"
    cp "${resource_path}/${appName}/${launch}" "${project_path}/${project_name}/Images.xcassets/LaunchImage.launchimage/${launch}"
done

n=0
while [[ n -lt ${#changeNames[@]} ]]; do

  changeName=${changeNames[n]}
  changeNameInProj=${changeNamesInProj[n]}
  let n++
  #替换app内用到的图标 和 首页那个图
  cp "${resource_path}/${appName}/${changeName}" "${project_path}/${project_name}/${changeNameInProj}"

done

}

group(){
  if [[ $all -eq 0 ]]; then
    echo "all=$all"
    appNames=${appNames[0]}
    appIds=${appIds[0]}
  fi

  appNames_new=appNames
  appIds_new=appIds

  i=0
  while [[ i -lt ${#appIds_new[@]} ]]; do

    appName=${appNames_new[i]}
    appId=${appIds_new[i]}
    let i++

    echo $appName
    #替换资源
    prepare

    #打包
    packaging

  done

  open $output_path

}
#---------------------------------------------------------------------------------------------------------------------------------

#打包
group
