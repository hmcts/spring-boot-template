FROM hmctspublic.azurecr.io/base/java:openjdk-11-distroless-1.0

COPY build/libs/spring-boot-template.jar /opt/app/

EXPOSE 4550
CMD [ "spring-boot-template.jar" ]
