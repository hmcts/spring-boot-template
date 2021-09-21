package uk.gov.hmcts.reform.pip.rules.smoketests;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.PropertySource;

@ComponentScan("uk.gov.hmcts.reform.pip.rules.smoketests")
@PropertySource("application.properties")
public class SmokeTestConfiguration {
}
