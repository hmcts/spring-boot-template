FROM hmcts/cnp-java-base:openjdk-jre-8-slim-stretch-1.0

ENV APP spring-boot-template.jar
ENV APPLICATION_TOTAL_MEMORY 1024M
ENV APPLICATION_SIZE_ON_DISK_IN_MB 41
ENV JAVA_OPTS ""

COPY build/libs/$APP /opt/app/

HEALTHCHECK --interval=10s --timeout=10s --retries=10 CMD http_proxy="" wget -q --spider http://localhost:4550/health || exit 1

EXPOSE 4550
