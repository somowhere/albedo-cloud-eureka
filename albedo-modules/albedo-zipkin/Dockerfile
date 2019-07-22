FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER somewhere0813@gmail.com

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /albedo-zipkin

WORKDIR /albedo-zipkin

EXPOSE 5002

ADD ./albedo-module/albedo-zipkin/target/albedo-zipkin.jar ./

CMD java -Djava.security.egd=file:/dev/./urandom -jar albedo-zipkin.jar
