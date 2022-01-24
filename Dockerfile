ARG APP_INSIGHTS_AGENT_VERSION=3.2.4
FROM hmctspublic.azurecr.io/base/java:11-distroless

COPY build/libs/spring-boot-template.jar /opt/app/

EXPOSE 4550
CMD [ "spring-boot-template.jar" ]
