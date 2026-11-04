## 프로젝트 개요
#### 내 컴퓨터에 개발자용 '작업실' 꾸미기
- Docker 및 Git 설치, 터미널 세팅하기.
   
### 1) 실행 환경
- OS: Ubuntu 26.04.1 LTS (WSL)
- Shell: bash
- Docker: 29.9.2
- Git: 2.53.0

### 2) 수행 체크리스트
- [X] 터미널 기본 조작 및 폴더 구성
- [X] Docker 설치/점검
- [X] hello-world 실행
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

- 컨테이너 종료/유지(attach/exec 등)의 차이
   >도커 컨테이너는 메인 프로세스(PID 1)가 살아있는 동안만 실행됨.
   
   >**docker attach** 명령어로 컨테이너 연결 시 메인프로세스(PID 1)에 직접적으로 연결.  
   >종료 시 exit을 입력하면 즉시 컨테이너가 종료 되기에 메인 프로세스에서 나오는 출력을 확인할 때 주로 사용. 컨테이너를 유지하며 빠져나올 때에는 Ctrl + P, Q
   
   >**docker exec** 명령어는 새 프로세스를 생성하여 컨테이너를 연결.  
   >exit 입력 시 컨테이너는 유지되기에 디버깅이나 추가 작업 등에 이용됨.

 - 기존 Dockerfile 기반 커스텀 이미지 제작  
   - (A) Nginx 웹 서버 베이스 이미지 활용.  
   - 이미지 크기가 작고 빌드가 빠르기에 Docker Hub 공식 이미지인 Nginx:alpine를 사용함. 

```Docker
FROM nginx:alpine (베이스)
COPY index.html /usr/share/nginx/html/index.html 
   (index.html을 이미지 안의 Nginx 웹 폴더로 복사.)
LABEL maintainer="호성" 
   (이미지에 작성자 이름 표기)
HEALTHCHECK --interval=30s CMD wget -q -O /dev/null http://localhost/ || exit 1 
   (도커가 30초마다 컨테이너 내에서 wget으로 localhost에 접속 시도. 페이지가 정상적으로 열리면 healthy, 
   실패하면 실패코드 반환. 여러번 실패 시 unhealthy)
```
 - 빌드 결과
```bash
$ sudo docker build -t my-nginx:1.0 .
[+] Building 4.8s (7/7) FINISHED                                                                docker:default
 => [internal] load build definition from Dockerfile                                                      0.0s
... 생략 ...
 => => unpacking to docker.io/library/my-nginx:1.0                                                        0.4s
 ```
  - 실행 결과
```bash
$ sudo docker run -d -p 8080:80 --name web my-nginx:1.0
```
 - localhost 접속  (8080 포트 매핑, 이미지 및 curl 결과)    
<img width="607" height="265" alt="image" src="https://github.com/user-attachments/assets/0510e28a-9ba0-4830-bb28-c136e00f5ab4" />
```bash
lhs3060753744@GNIA-C402-J01:~$ curl http://localhost:8080
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>My Nginx</title></head>
<body><h1>Hello, World!</h1></body>
</html>
```
 #### Docker 바인드 마운트
 1. 바인드 마운트로 컨테이너 실행
 ```bash
 lhs3060753744@GNIA-C402-J01:.../lhs/Dev-Setup$ sudo docker run -d -p 8082:80 --name bind-test -v $(pwd):/usr/share/nginx/html nginx:alpine   
Unable to find image 'nginx:alpine' locally
alpine: Pulling from library/nginx
Digest: sha256:785835ea65db4bba6f021acc0f3be91b0fef76a53fe41f8588c6698d2aed0606
Status: Downloaded newer image for nginx:alpine
49bae50114a126abb892e2e1ea727191dfef4652d61e91afe8b83f814b0a64c4
lhs3060753744@GNIA-C402-J01:.../lhs/Dev-Setup$ curl http://localhost:8082
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>My Nginx</title></head>
<body><h1>Hello, World!</h1></body>
```
 2. 연결 방식 확인
 ```bash
 lhs3060753744@GNIA-C402-J01:/mnt/c/Users/lhs3060753744/Desktop/lhs/Dev-Setup$ sudo docker inspect --format '{{json .Mounts}}' bind-test
[{"Type":"bind","Source":"/mnt/c/Users/lhs3060753744/Desktop/lhs/Dev-Setup","Destination":"/usr/share/nginx/html","Mode":"","RW":true,"Propagation":"rprivate"}]
```
"Type":"bind", 폴더 경로가 보임 -> 바인드 마운트

 3. 호스트에서 파일 수정 후 반영 확인
 ```bash
 lhs3060753744@GNIA-C402-J01:.../lhs/Dev-Setup$ curl http://localhost:8082
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>My Nginx</title></head>
<body><h1>Bind Mount Test!</h1></body>
</html>
```

 #### Docker 볼륨 영속성 검증
 1. 볼륨 생성
 ```bash
 lhs3060753744@GNIA-C402-J01:~$ sudo docker volume create mydata
mydata
lhs3060753744@GNIA-C402-J01:~$ sudo docker volume ls
DRIVER    VOLUME NAME
local     mydata
```
 2. 볼륨 연결 및 컨테이너 실행
 ```bash
 lhs3060753744@GNIA-C402-J01:~$ sudo docker run -d --name vol-test -v mydata:/data ubuntu sleep infinity
d526c8e47b09e49033686d028c095186430d0830655d2842904812a2aa9c0c1e
lhs3060753744@GNIA-C402-J01:~$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                    PORTS                                     NAMES
d526c8e47b09   ubuntu         "sleep infinity"         5 seconds ago    Up 4 seconds                                                        vol-test
```
 3. 데이터 쓰기 (컨테이너 삭제 전 확인)
 ```bash
 lhs3060753744@GNIA-C402-J01:~$ sudo docker exec -it vol-test bash -lc "echo hi > /data/hello.txt && cat /data/hello.txt"
hi
```
 4. 컨테이너 삭제
 ```bash
 lhs3060753744@GNIA-C402-J01:~$ sudo docker rm -f vol-test
vol-test
lhs3060753744@GNIA-C402-J01:~$ sudo docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                    PORTS                                     NAMES
```
 5. 새 컨테이너에 같은 볼륨 연결 (기존 컨테이너 삭제 후 확인)
```bash
lhs3060753744@GNIA-C402-J01:~$ sudo docker run -d --name vol-test2 -v mydata:/data ubuntu sleep infinity
6d9aee5a324a51f6665881c59b23de78bfea444544a00b52baae7d404096bfb4
lhs3060753744@GNIA-C402-J01:~$ sudo docker exec -it vol-test2 bash -lc "cat /data/hello.txt"
hi
```

#### Git 설정 및 GitHub 연동
 - Git 설정
 ```git
 lhs3060753744@GNIA-C402-J01 UCRT64 ~/Desktop/lhs/Dev-Setup (main)
$ git config --global user.name "lhs306075"

lhs3060753744@GNIA-C402-J01 UCRT64 ~/Desktop/lhs/Dev-Setup (main)
$ git config --global user.email "lhs306075@gmail.com"

lhs3060753744@GNIA-C402-J01 UCRT64 ~/Desktop/lhs/Dev-Setup (main)
$ git config --global init.defaultBranch main
```
```git
lhs3060753744@GNIA-C402-J01 UCRT64 ~/Desktop/lhs/Dev-Setup (main)
$ git config --list
diff.astextplain.textconv=astextplain
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
http.sslbackend=schannel
core.autocrlf=true
core.fscache=true
core.symlinks=false
pull.rebase=false
credential.helper=manager
credential.https://dev.azure.com.usehttppath=true
init.defaultbranch=master
user.name=lhs306075
user.email=lhs306075@gmail.com
init.defaultbranch=main
```
- GitHub 연동 (VSCode)
```git
lhs3060753744@GNIA-C402-J01 UCRT64 ~/Desktop/lhs/Dev-Setup (main)
$ git remote -v
origin  https://github.com/lhs306075/Dev-Setup.git (fetch)
origin  https://github.com/lhs306075/Dev-Setup.git (push)
```
<img width="1030" height="612" alt="image" src="https://github.com/user-attachments/assets/99ed3559-2e64-4cc7-93b9-dda1d56bb50f" />
