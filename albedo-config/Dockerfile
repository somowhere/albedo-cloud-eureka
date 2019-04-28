FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER somewhere0813@gmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /albedo-config

WORKDIR /albedo-config

EXPOSE 4001

ADD ./albedo-config/target/albedo-config.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar albedo-config.jar
