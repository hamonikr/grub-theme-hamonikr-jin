#!/bin/bash

# grub-theme-hamonikr-jin
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

ROOT_UID=0
THEME_DIR="/boot/grub/themes"
THEME_DIR_2="/boot/grub2/themes"
THEME_NAME=hamonikr-jin

# Welcome message
echo -e "\n\t*****************************\n\t*  ${THEME_NAME} - Grub2 Theme  *\n\t*****************************"

# Check command avalibility
function has_command() {
  command -v $1 > /dev/null
}

echo -e "\nChecking for root access..."

# Checking for root access and proceed if it is present
if [ "$UID" -eq "$ROOT_UID" ]; then

  # Create themes directory if not exists
  echo -e "Checking for the existence of themes directory..."
  [[ -d ${THEME_DIR}/${THEME_NAME} ]] && rm -rf ${THEME_DIR}/${THEME_NAME}
  [[ -d ${THEME_DIR_2}/${THEME_NAME} ]] && rm -rf ${THEME_DIR_2}/${THEME_NAME}
  [[ -d /boot/grub ]] && mkdir -p ${THEME_DIR}
  [[ -d /boot/grub2 ]] && mkdir -p ${THEME_DIR_2}

  # Copy theme
  echo -e "Installing ${THEME_NAME} theme..."
  [[ -d /boot/grub ]] && cp -a boot/grub/themes/${THEME_NAME} ${THEME_DIR}
  [[ -d /boot/grub2 ]] && cp -a boot/grub/themes/${THEME_NAME} ${THEME_DIR_2}

  # Set theme
  echo -e "Setting ${THEME_NAME} as default..."
  grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub

  [[ -d /boot/grub ]] && echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
  [[ -d /boot/grub2 ]] && echo "GRUB_THEME=\"${THEME_DIR_2}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub

  # 사용중인 해상도를 감지해서 적합한 크기로 조정
  # https://en.wikipedia.org/wiki/Display_resolution
  RATIO=`./get_resolution.sh`
  RESOLUTION="1920x1200"
  [[ "$RATIO" == "16:9" ]] && RESOLUTION="1920x1080"

  # 실제 모니터의 해상도를 적용하려면 아래 처럼 사용
  RESOLUTION=`xrandr --current | grep "*" | head -n 1 | awk -F" " '{print $1}'`

  sed -i.bak "s/.*GRUB_GFXMODE.*/GRUB_GFXMODE=${RESOLUTION}/g" /etc/default/grub
  
  # Update grub config
  echo -e "Updating grub config..."
  if has_command update-grub; then
    update-grub
  elif has_command grub-mkconfig; then
    grub-mkconfig -o /boot/grub/grub.cfg
  elif has_command grub2-mkconfig; then
    grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
  fi

  # Success message
  echo -e "\n\t          ***************\n\t          *  All done!  *\n\t          ***************\n"

else
    # Error message
    echo -e "\n\t   ******************************\n\t   *  Error! -> Run me as root  *\n\t   ******************************\n"
fi
