# -*- coding: utf-8 -*-
import os
import sys
import time
import user_Input_Info as input_info
import change_file_content as change_server
# 项目根目录
project_path = ""
serverFilePath = project_path + "/copm_cust/Business/Login/other/Const.m"
#工程名称
projectName = "copm_cust"+".xcodeproj"
#scheme
scheme = "copm_cust"
# 打包后ipa存储目录
targerIPA_parth = ""

#时间戳
timeStr = time.strftime('%Y-%m-%d_%H-%M-%S',time.localtime(time.time()))
#activePath
activePath = targerIPA_parth  + timeStr +"/" +timeStr+".xcarchive"
#蒲公英Key
PGY_key=""
#蒲公英APIKey
PGY_APIkey=""
DOWNLOAD_BASE_URL = "http://www.pgyer.com"
PGYER_UPLOAD_URL  = "http://www.pgyer.com/apiv1/app/upload"



# 清理项目 创建build目录
def clean_project_mkdir_build():
    print("******clean******")

    os.system('cd %s;xcodebuild clean -project "%s" -scheme %s -configuration release  | xcpretty' % (project_path,projectName,scheme)) # clean 项目

def build_project():
    print("build xcarchive start")
    print("activePath %s"%(activePath))

    os.system('xcodebuild -list | xcpretty')
    # os.system('cd %s;xcodebuild archive -project "%s" -scheme %s -configuration release -sdk iphoneos11.4  IPHONEOS_DEPLOYMENT_TARGET=9.0 -archivePath %s  -quiet | xcpretty >> %slog.txt;   ' %
    #           (project_path, projectName, scheme, activePath, targerIPA_parth + timeStr ))

    os.system('cd %s;xcodebuild archive -project "%s" -scheme %s -configuration release -sdk iphoneos11.4  IPHONEOS_DEPLOYMENT_TARGET=9.0 -archivePath %s  -quiet | xcpretty;   ' %
              (project_path, projectName, scheme, activePath))


    # os.system('mv %slog.txt %slog.txt' %(targerIPA_parth + timeStr, targerIPA_parth + timeStr + '/'))

    print("build xcarchive end")

# 打包ipa 并且保存在桌面
def build_ipa():
    print("build IPA start")
    os.chdir(targerIPA_parth)
    os.system('xcodebuild -exportArchive -archivePath %s -exportPath %s/%s -exportOptionsPlist %sIPA.plist -quiet | xcpretty'%(activePath,targerIPA_parth,timeStr,targerIPA_parth))
    print("build IPA end")

def uploadIpaToPgyer(updateDescription):
    ipaPath = "%s%s/copm_cust.ipa"%(targerIPA_parth,timeStr)
    print ("ipaPath:"+ipaPath)
    files = {'file': open(ipaPath, 'rb')}
    headers = {'enctype':'multipart/form-data'}
    payload = {'uKey':PGY_key,'_api_key':PGY_APIkey,'updateDescription':updateDescription}
    print ("uploading....")
    r = requests.post(PGYER_UPLOAD_URL, data = payload ,files=files,headers=headers)
    if r.status_code == requests.codes.ok:
        print (r.status_code)
        result = r.json()
        parserUploadResult(result)
    else:
        print ('HTTPError,Code:'+r.status_code)

def parserUploadResult(jsonResult):
    resultCode = jsonResult['code']
    if resultCode == 0:
        downUrl = DOWNLOAD_BASE_URL +"/"+jsonResult['data']['appShortcutUrl']
        print ("Upload Success")
        print ("DownUrl is:" + downUrl)
    else:
        print ("Upload Fail!")
        print ("Reason:"+jsonResult['message'])

def updateSVN():
    print("更新SVN数据")
    os.chdir(project_path)

    print("更新SVN数据 %s"%(os.getcwd()))
    os.system('svn update ')
    time.sleep(1)

    print("更新SVN完成")

def updateIPAToPGY(updateDescription):
    print("开始上传蒲公英")

    os.system ('curl -F \"updateDescription=%s\" -F \"file=@%s%s/copm_cust.ipa\" -F \"uKey=%s\" -F \"_api_key=%s\" https://qiniu-storage.pgyer.com/apiv1/app/upload'%(updateDescription,targerIPA_parth,timeStr,PGY_key,PGY_APIkey))
    print("上传蒲公英完成")

def creatQQMessage(updateDescription):
    file_object = open('/Users/Yunis/Documents/临时放置/ZDDB/QQ优你家.txt', 'w')
    file_object.write(updateDescription)
    file_object.close()
    os.system("open /Users/Yunis/Documents/临时放置/ZDDB/QQ优你家.txt")
    os.system("open /Users/Yunis/Documents/临时放置/ZDDB/QRCode.rtfd")


def main():
    #更新SVN
    updateSVN()

    # 用户输入要打包的服务器地址
    address1 = input_info.inputServer()
    # 用户输入本次更新的信息
    updateDescription = input_info.inputUpdateInfo(address1,"优你家")
    print(str(updateDescription))
    # 修改源文件
    change_server.modify_to_target_server(serverFilePath,address1)

    # 清理并创建build目录
    clean_project_mkdir_build()
    # 编译coocaPods项目文件并 执行编译目录
    build_project()
    # 打包ipa 并制定到桌面
    build_ipa()
    #上传到蒲公英
    updateIPAToPGY(updateDescription)
    # 生成更新下载信息
    creatQQMessage(updateDescription)

# 执行
main()
