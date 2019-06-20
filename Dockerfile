FROM jenkins/jnlp-slave:3.29-1

########################################################
### Update Java security policies
########################################################

USER root

RUN wget -O jce_policy.zip  --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip \
  && unzip jce_policy.zip && rm jce_policy.zip \
  && cp UnlimitedJCEPolicyJDK8/*.jar ${JAVA_HOME}/jre/lib/security/

RUN sed -i '/#networkaddress.cache.ttl=-1/c\networkaddress.cache.ttl=0' ${JAVA_HOME}/jre/lib/security/java.security

USER jenkins

########################################################
### Install Allure
########################################################

ENV ALLURE_VERSION 2.12.1

RUN wget -O allure.zip https://dl.bintray.com/qameta/maven/io/qameta/allure/allure-commandline/${ALLURE_VERSION}/allure-commandline-${ALLURE_VERSION}.zip
RUN unzip allure.zip && rm allure.zip
RUN mv allure-${ALLURE_VERSION} allure

ENV ALLURE_HOME /home/jenkins/allure

########################################################
### Start Slave
########################################################

ENTRYPOINT ["jenkins-slave"]