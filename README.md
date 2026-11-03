## 프로젝트 개요
#### 내 컴퓨터에 개발자용 '작업실' 꾸미기
- Docker 및 Git 설치, 터미널 세팅하기.
   
### 1) 실행 환경
- OS: Ubuntu 26.04.1 LTS (WSL)
- Shell: bash
- Docker: 29.9.2
- Git: 2.53.0

### 2) 수행 체크리스트
- [O] 터미널 기본 조작 및 폴더 구성
- [O] Docker 설치/점검
- [O] hello-world 실행
- [x] Dockerfile 빌드/실행
- [x] 포트 매핑 접속(2회)
- [x] 바인드 마운트 반영
- [x] 볼륨 영속성
- [x] Git 설정 + VSCode GitHub 연동

 ### 3) 수행 로그(발췌)
 #### 기본 터미널 조작
 - 현재 위치 확인
```bash
lhs3060753744@GNIA-C201-C03:~$ pwd
/home/lhs3060753744
```
 - 목록 확인(숨김 파일 포함)
```bash
lhs3060753744@GNIA-C201-C03:~$ ls -la
total 28
drwxr-x--- 4 lhs3060753744 lhs3060753744 4096 Nov  3 13:59 .
drwxr-xr-x 3 root          root          4096 Nov  3 13:59 ..
-rw-r--r-- 1 lhs3060753744 lhs3060753744  220 Nov  3 13:59 .bash_logout
-rw-r--r-- 1 lhs3060753744 lhs3060753744 3771 Nov  3 13:59 .bashrc
drwxr-x--- 4 lhs3060753744 lhs3060753744 4096 Nov  3 13:59 .cache
drwxr-x--- 3 lhs3060753744 lhs3060753744 4096 Nov  3 13:59 .config
-rw-rw-r-- 1 lhs3060753744 lhs3060753744    0 Nov  3 13:59 .motd_shown
-rw-r--r-- 1 lhs3060753744 lhs3060753744  807 Nov  3 13:59 .profile
```
 - 폴더 생성
```bash
lhs3060753744@GNIA-C201-C03:~$ mkdir test1
lhs3060753744@GNIA-C201-C03:~$ ls
test1
```
 - 경로 이동
```bash
lhs3060753744@GNIA-C201-C03:~$ cd test1
lhs3060753744@GNIA-C201-C03:~/test1$ pwd
/home/lhs3060753744/test1
```
 - 빈 파일 생성
```bash
lhs3060753744@GNIA-C201-C03:~/test1$ touch test2
lhs3060753744@GNIA-C201-C03:~/test1$ ls
test2
```
 - 텍스트 파일 생성 / 내용 확인
```bash
lhs3060753744@GNIA-C201-C03:~/test1$ echo "Hello World!" > test3.txt
lhs3060753744@GNIA-C201-C03:~/test1$ cat test3.txt
Hello World!
```
 - 파일 복사
```bash
lhs3060753744@GNIA-C201-C03:~/test1$ cp test3.txt testcopy.txt
lhs3060753744@GNIA-C201-C03:~/test1$ cat testcopy.txt
Hello World!
```
 - 파일 이동 / 이름 변경
```bash
lhs3060753744@GNIA-C201-C03:~/test1$ mv testcopy.txt ./copyfolder/testcopy2.txt
lhs3060753744@GNIA-C201-C03:~/test1$ ls
copyfolder  test2  test3.txt
lhs3060753744@GNIA-C201-C03:~/test1$ cd copyfolder
lhs3060753744@GNIA-C201-C03:~/test1/copyfolder$ ls
testcopy2.txt
lhs3060753744@GNIA-C201-C03:~/test1/copyfolder$ cat testcopy2.txt
Hello World!
```
 - 파일 삭제
```bash
lhs3060753744@GNIA-C201-C03:~/test1$ ls
copyfolder  test2  test3.txt
lhs3060753744@GNIA-C201-C03:~/test1$ rm test3.txt
lhs3060753744@GNIA-C201-C03:~/test1$ ls
copyfolder  test2
```
 - 폴더 삭제
```bash
lhs3060753744@GNIA-C201-C03:~/test1$ rm -r copyfolder
lhs3060753744@GNIA-C201-C03:~/test1$ ls
test2
```

#### 권한 실습
 - 권한 확인
```bash
lhs3060753744@GNIA-C201-C03:~/test1$ ls -l
total 8
-rw-r--r-- 1 lhs3060753744 lhs3060753744   13 Nov  3 14:37 test2
drwxr-xr-x 2 lhs3060753744 lhs3060753744 4096 Nov  3 14:51 testfolder
```
 - 파일 권한 변경 (User에게 실행권한 추가)
 ```bash
lhs3060753744@GNIA-C201-C03:~/test1$ chmod u+x test2
lhs3060753744@GNIA-C201-C03:~/test1$ ls -l
total 8
-rwxr--r-- 1 lhs3060753744 lhs3060753744   13 Nov  3 14:37 test2
drwxr-xr-x 2 lhs3060753744 lhs3060753744 4096 Nov  3 14:51 testfolder
```
 - 폴더 및 하위 파일 권한 변경 (유저 : 읽기/쓰기, 그룹 : 읽기, 기타 : 읽기/실행)
```bash
lhs3060753744@GNIA-C201-C03:~/test1$ chmod -R 645 testfolder
lhs3060753744@GNIA-C201-C03:~/test1$ ls -l
total 8
-rwxr--r-- 1 lhs3060753744 lhs3060753744   13 Nov  3 14:37 test2
drw-r--r-x 2 lhs3060753744 lhs3060753744 4096 Nov  3 14:51 testfolder
```

 #### Docker 설치 및 기본 점검
 - Docker 버전 확인 결과
```bash
lhs3060753744@GNIA-C201-C03:~$ docker --version
Docker version 29.9.2, build a82e528
```
 - Docker 데몬 동작 여부 확인 결과
```bash
lhs3060753744@GNIA-C201-C03:~$ docker info
Client: Docker Engine - Community
 Version:    29.9.2
 Context:    default
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.38.1
    Path:     /usr/libexec/docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v5.7.0
    Path:     /usr/libexec/docker/cli-plugins/docker-compose

Server:
permission denied while trying to connect to the docker API at unix:///var/run/docker.sock
```

 #### Docker 기본 운영 명령 수행
  - 이미지 목록 확인
 ```bash
lhs3060753744@GNIA-C201-C03:~/test1$ sudo docker images
[sudo: authenticate] Password:
                                                                                                    i Info →   U  In Use
IMAGE                ID             DISK USAGE   CONTENT SIZE   EXTRA
hello-world:latest   c567b231f656       25.9kB         9.49kB    U
```
 - 컨테이너 실행/중지/목록 확인
```bash
lhs3060753744@GNIA-C201-C03:~/test1$ sudo docker ps -a
CONTAINER ID   IMAGE         COMMAND    CREATED          STATUS                      PORTS     NAMES
5c82f48615c9   hello-world   "/hello"   52 minutes ago   Exited (0) 52 minutes ago             exciting_bose
```

 #### 컨테이너 실행 실습
 - hello-world 컨테이너 실행
```bash
lhs3060753744@GNIA-C201-C03:/mnt/c/Windows/system32$ sudo docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
4f55086f7dd0: Pull complete
d5e71e642bf5: Download complete
Digest: sha256:c567b231f65614688711a75f31518a064258a51d442117a3e771a3a8fdba78ef
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```
 - ubuntu 컨테이너 실행 및 간단한 명령 실행
 ``` bash
lhs3060753744@GNIA-C201-C03:~/test1$ sudo docker run -it --name ubuntu ubuntu:latest /bin/bash
root@48dec1668090:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@48dec1668090:/# echo "Hello World"
Hello World
root@48dec1668090:/# exit
exit
lhs3060753744@GNIA-C201-C03:~/test1$
```


 - git 설치 및 계정 연동


