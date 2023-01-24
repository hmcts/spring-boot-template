 # renovate: datasource=github-releases depName=microsoft/ApplicationInsights-Java
ARG APP_INSIGHTS_AGENT_VERSION=3.4.8
FROM hmctspublic.azurecr.io/base/java:17-distroless

COPY build/libs/spring-boot-template.jar /opt/app/

EXPOSE 4550
CMD [ "spring-boot-template.jar" ]
