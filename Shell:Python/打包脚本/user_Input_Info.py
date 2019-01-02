import sys
import getopt

from termcolor import colored

address = ""
updateDescription = ""
updateInfoFile = "/Users/Yunis/Documents/临时放置/ZDDB/newfile/updateDescription.txt"

def inputServer():
    print(colored("输入服务器地址,服务器地址如下：","blue"))
    print(colored("""
    "测试内网138": "http://xxxx",
        ""","yellow"))
    address = input()
    servers = ["测试内网138"]
    if address not in servers:
        print(colored("请输入正确的服务器地址","red"))
        inputServer()
    else:
        print(colored("输入的地址为 %s"%(address),"green"))
        return address



def inputUpdateInfo(server,appType):
    print("appType %s" % (appType))
    print("请输入本次更新内容")

    updateInfo = file_write()
    print(updateInfo)
    if updateInfo:
        if appType == "XXX":
            print("11appType %s" % (appType))
            updateDescription = "XXX （%s)\n下载地址：https://www.pgyer.com/XXXX\n更新：\n%s"%(server,updateInfo)
            print(colored("本次更新内容为 %s"%(updateDescription),"green"))
        return updateDescription
    else:
        print(colored("请输入更新内容","red"))
        inputUpdateInfo(server)



def file_write():
    f = open(updateInfoFile, 'w')
    print('请输入内容【单独输入\':q\'保存退出】：')
    while True:
        file_content = input()
        if file_content != ':q':
            f.write('%s\n' % file_content)
        else:
            break
    f.close()

    f = open(updateInfoFile, 'r')
    updateInfo=f.read()
    f.close()
    return updateInfo
