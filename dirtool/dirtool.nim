# Tool to create basic AppDir structure

import os
import strformat

var folder = ""

proc mkstruct(dir: string) =
    if not dirExists(dir):
        folder = dir & ".AppDir"
        var usr:string = &"{folder}/usr"
        var bin:string = &"{folder}/usr/bin"
        var AppRun:string = &"{folder}/" & "AppRun"
        let AppRunContents = """#!/bin/bash

# Get the directory where AppRun is located (the root of the AppImage)
APPDIR="$(dirname "$(readlink -f "$0")")"

# Export this directory so the app knows where it is
export APPDIR

# Finally, launch your 'test' application.
# The "$@" passes any arguments given to the AppImage directly to 'test'.
exec "$APPDIR/usr/bin/test" "$@"
#exec ruby "$APPDIR/script.rb" "$@""""
        createDir(folder)
        createDir(usr)
        createDir(bin)
        writeFile(AppRun, AppRunContents)
        setFilePermissions(AppRun, {fpUserRead, fpUserWrite, fpUserExec, fpGroupRead, fpGroupExec, fpOthersRead, fpOthersExec})
    else:
        echo &"Error, directory {dir} exists. Quitting." 
        quit(1)
        

if paramCount() < 1:
    echo "Usage: dirtool 'app name'"
elif 1 == paramCount():
    var app_name:string = paramStr(1)
    mkstruct(app_name)
    echo "Made " & folder
