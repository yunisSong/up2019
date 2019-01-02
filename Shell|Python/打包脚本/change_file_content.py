# -*- coding: utf-8 -*-
import os
import re

fileAddress = ""

def formatServerContent(file):
    fr = open(file,'r',encoding="utf-8")
    lines = fr.readlines()
    for line in lines:
        # 匹配 行中 带有 BaseAddress 的行
        if re.match(".*BaseAddress.*", line) != None:
            # 匹配开头 是否为 //
            if re.match("^//", line) is None:
                # 如果开头 不为 // ，为头添加 //
                index =lines.index(line)
                lines[index] = "//" + line

    #写文件
    fw = open(file,'w+')
    fw.writelines(lines)


def modify_to_target_server(file,server):
    # 先复原文件
    formatServerContent(file)

    serverAdd = switch_to_server(server)

    fr = open(file,'r',encoding="utf-8")
    lines = fr.readlines()
    for line in lines:
        # 匹配 行中 带有 要打包服务器地址 的行
        if re.match(".*%s.*"%(serverAdd), line) != None:
            # 匹配开头 是否为 //
            if re.match("^//", line) != None:
                # 如果开头 为 // ，为头除去 //
                index =lines.index(line)
                lines[index] = line[2:]

    #写文件
    fw = open(file,'w+')
    fw.writelines(lines)

def switch_to_server(argument):
    switcher = {
        "测试内网": "http:xxxx",
   
    }
    return switcher.get(argument, "nothing")


