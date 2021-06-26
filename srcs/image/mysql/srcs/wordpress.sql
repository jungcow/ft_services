-- jungwkim 이라는 유저 생성(비밀번호는 980502 로 설정)
CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY '1234';

-- jungwkim 에게 모든 데이터베이스에 대한 모든 권한을 승인.
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY '1234' WITH GRANT OPTION;

-- 변동 사항을 바로 저장.
FLUSH PRIVILEGES;

-- phpmyadmin 과 wordpress 데이터베이스를 생성해준다. 
CREATE DATABASE IF NOT EXISTS wordpress;
