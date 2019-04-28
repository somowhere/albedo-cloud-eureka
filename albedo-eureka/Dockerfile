FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER somewhere0813@gmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /albedo-eureka

WORKDIR /albedo-eureka

EXPOSE 8761

ADD ./albedo-eureka/target/albedo-eureka.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar albedo-eureka.jar
