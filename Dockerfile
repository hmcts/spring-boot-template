FROM hmcts/cnp-java-base:openjdk-8u191-jre-alpine3.9-2.0.1

ENV APPLICATION_TOTAL_MEMORY 1024M
ENV APPLICATION_SIZE_ON_DISK_IN_MB 41
ENV JAVA_OPTS ""

COPY build/libs/spring-boot-template.jar /opt/app/

HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD http_proxy="" wget -q --spider http://localhost:4550/health || exit 1

EXPOSE 4550
CMD [ "spring-boot-template.jar" ]
