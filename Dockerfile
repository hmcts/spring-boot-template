# also update version in RUN wget line, when changing, it doesn't seem to expand in the URL for some reason if you try use this ARG
ARG APP_INSIGHTS_AGENT_VERSION=2.5.0
# Build image

FROM busybox as downloader

RUN wget -P /tmp https://github.com/microsoft/ApplicationInsights-Java/releases/download/2.5.0/applicationinsights-agent-2.5.0.jar
# Application image

FROM hmctspublic.azurecr.io/base/java:openjdk-11-distroless-1.1

COPY --from=downloader /tmp/applicationinsights-agent-${APP_INSIGHTS_AGENT_VERSION}.jar /opt/app/
COPY lib/AI-Agent.xml /opt/app/
COPY build/libs/spring-boot-template.jar /opt/app/

EXPOSE 4550
CMD [ "spring-boot-template.jar" ]
