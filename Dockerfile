FROM openjdk:8-jre

COPY build/install/spring-boot-template /opt/app/

WORKDIR /opt/app

# TODO: change the port number to the one your application is set to listen on
HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD http_proxy="" curl --silent --fail http://localhost:4550/health

# TODO: change to your application's port number
EXPOSE 4550

ENTRYPOINT ["/opt/app/bin/spring-boot-template"]
