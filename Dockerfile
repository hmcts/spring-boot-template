FROM openjdk:8-jre

COPY .env /

RUN export $(cat .env | xargs)

COPY build/install/spring-boot-template /opt/app/

WORKDIR /opt/app

HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD http_proxy="" curl --silent --fail http://localhost:${SERVER_PORT}/health

EXPOSE $SERVER_PORT

ENTRYPOINT ["/opt/app/bin/spring-boot-template"]
