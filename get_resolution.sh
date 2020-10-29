#!/usr/bin/env bash

# grub-theme-hamonikr
# grub theme for HamoniKR-ME (>= 1.4)
# Copyright (C) 2019 Kevin Kim (root@hamonikr.org)
# - 사용자 해상도 자동 감지 후 테마 적용
# - 와이드 스크린의 경우 자동으로 비율을 계산
# - 한글 폰트로 grub 테마 제작
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

## The location of the file with the resolutions
RESOLUTIONS="./resolutions.txt" 

# xrandr -q | grep -Po 'current\s*\K\d+\s*x\s*\d+' | sed 's/ *x */ /' | 
xrandr --current | grep "*" | head -n 1 | sed 's/ *x */ /' | awk -F" " '{print $1 " " $2}' |
while read x y; do 
    grep "$x" "$RESOLUTIONS" | grep "$y" | awk -F" " '{print $2}'; 
done 