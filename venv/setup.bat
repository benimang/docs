chcp 65001
@echo off

SET PYPI_URL=https://pypi.douban.com/simple

python -m venv ./
Scripts\python.exe -m pip install --upgrade pip -i %PYPI_URL%
Scripts\pip install -U -r requirement.txt -i %PYPI_URL%

pause