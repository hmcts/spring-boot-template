ARG APP_INSIGHTS_AGENT_VERSION=2.6.4
FROM hmctspublic.azurecr.io/base/java:11-distroless

COPY lib/AI-Agent.xml /opt/app/
COPY build/libs/spring-boot-template.jar /opt/app/

EXPOSE 4550
CMD [ "spring-boot-template.jar" ]
