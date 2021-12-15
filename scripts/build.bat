chcp 65001
@echo off

cd ..

mkdocs build
TortoiseGitProc.exe /command:commit

