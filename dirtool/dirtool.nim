# Tool to create basic AppDir structure

import os
import strformat

proc mkstruct(dir: string) =
    if not dirExists(dir):
        var folder:string = dir & ".AppDir"
        var usr:string = &"{folder}/usr"
        var bin:string = &"{folder}/usr/bin"
        var AppRun:string = &"{folder}/" & "AppRun"
        createDir(folder)
        createDir(usr)
        createDir(bin)
        writeFile(AppRun, "")
    else:
        echo &"Error, directory {dir} exists. Quitting." 
        quit(1)
        

if paramCount() < 1:
    echo "Usage: dirtool 'app name'"
elif 1 == paramCount():
    var app_name:string = paramStr(1)
    mkstruct(app_name)
