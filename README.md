# Spring Boot application template

[![Build Status](https://travis-ci.org/hmcts/spring-boot-template.svg?branch=master)](https://travis-ci.org/hmcts/spring-boot-template)

## Purpose

The purpose of this template is to speed up the creation of new Spring applications within HMCTS
and help keep the same standards across multpile teams. If you need to create a new app, you can
simply use this one as a starting point and build on top of it.

TODO: complete the readme

## Plugins

The template contains the following plugins:

  * checkstyle

    https://docs.gradle.org/current/userguide/checkstyle_plugin.html

    Performs quality checks on Java source files using Checkstyle and generates reports from these checks.
    The checks are included in gradle's *check* task (you can run them by executing `gradle check` command).

  * org.sonarqube

    https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner+for+Gradle

    Triggers SonarQube analysis.
    You can start the analysis by executing the following command:

    `gradle sonarqube`

  * jacoco

    https://docs.gradle.org/current/userguide/jacoco_plugin.html

    Provides code coverage metrics for Java code via integration with JaCoCo.
    You can create the report by running the following command:

    `gradle jacocoTestReport`

    The report will be created in build/reports subdirectory in your project directory.

  * io.spring.dependency-management

    https://github.com/spring-gradle-plugins/dependency-management-plugin

    Provides Maven-like dependency management. Allows you to declare dependency management
    using `dependency 'groupId:artifactId:version'`
    or `dependency group:'group', name:'name', version:version'`.

  * org.springframework.boot

    http://projects.spring.io/spring-boot/

    Reduces the amount of work needed to create a Spring application

  * org.owasp.dependencycheck

    https://jeremylong.github.io/DependencyCheck/dependency-check-gradle/index.html

    Provides monitoring of the project's dependent libraries and creating a report
    of known vulnerable components that are included in the build. To run it
    execute `gradle dependencyCheck` command.

  * com.github.ben-manes.versions

    https://github.com/ben-manes/gradle-versions-plugin

    Provides a task to determine which dependencies have updates. Usage:

    `gradle dependencyUpdates -Drevision=release`
