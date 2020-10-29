![hamonikr-me](https://img.shields.io/badge/hamonikr-me-orange)
![hamonikr-64](https://img.shields.io/badge/hamonikr-64bit-green)
![hamonikr-1.4](https://img.shields.io/badge/hamonikr-1.4-blueviolet)
![hamonikr 3.0](https://img.shields.io/badge/hamonikr-3.0-brightgreen)

# grub-theme-hamonikr-jin

 * HamoniKR-ME (>= 1.4) 지원
 * 사용자 해상도 자동 감지 후 테마 적용
 * 와이드 스크린의 경우 자동으로 비율을 계산
 * 한글 폰트로 grub 테마 제작

# License
 * GPL v3

# Install
다운로드 받은 디렉토리 안으로 이동하여 아래 명령어를 입력

```sudo ./install.sh```

설치 후 시스템을 재시작 하면 grub 테마가 적용됩니다.

 * 테마 화면이 보이지 않는 경우 grub 설정을 확인하세요. (하모니카의 기본값은 hidden)
 ```cat /etc/default/grub | grep GRUB_TIMEOUT_STYLE```
 * 위 명령어의 결과가 hidden 으로 되어 있는 경우 grub 화면이 숨겨져서 보이지 않습니다.
 * ```#GRUB_TIMEOUT_STYLE=hidden``` 처럼 해당 줄의 맨 앞에 '#' 표시를 추가하고 저장 후 ```sudo update-grub``` 으로 grub 이미지를 재생성 후 시스템을 재시작하세요.

# 테마 수정
 * 테마를 수정하려면 hamonikr/theme.txt 파일을 수정할 수 있습니다.
 * 기본 제공되는 폰트는 5종(16pt 3종, 24pt 2종) 입니다.

## image specification
 * grub이 사용할 수 있는 이미지는 600x480 크기로 된 8bit 이하(256컬러)의 이미지 입니다. 
 * [https://help.ubuntu.com/community/Grub2/Displays](https://help.ubuntu.com/community/Grub2/Displays)

 * 다음과 같이 convert 명령어를 사용하면 쉽게 변환할 수 있습니다. (만약 convert 명령어가 없다면 apt 를 이용하여 ImageMagick 패키지를 설치)

ref : [https://wiki.debian.org/Grub/SplashImage](https://wiki.debian.org/Grub/SplashImage)

```
convert background.jpg -resize 1920x1080 -colors 14 +dither output1.jpg 
```

 # 이슈 또는 버그
 사용 중 문제를 발견하시면 root@hamonikr.org 또는 https://groups.google.com/forum/m/#!forum/hamonikr 에서 알려주세요.
