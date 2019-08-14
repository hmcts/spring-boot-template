ARG APP_INSIGHTS_AGENT_VERSION=2.3.1
FROM hmctspublic.azurecr.io/base/java:openjdk-11-distroless-1.0

COPY build/libs/spring-boot-template.jar /opt/app/
COPY lib/applicationinsights-agent-2.3.1.jar lib/AI-Agent.xml /opt/app/

EXPOSE 4550
CMD [ "spring-boot-template.jar" ]
