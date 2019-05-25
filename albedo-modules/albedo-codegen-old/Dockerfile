FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER somewhere0813@gmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /albedo-codegen

WORKDIR /albedo-codegen

EXPOSE 5003

ADD ./albedo-visual/albedo-codegen/target/albedo-codegen.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar albedo-codegen.jar
