FROM jenkins/jnlp-slave:3.23-1

ENV ALLURE_VERSION 2.7.0

RUN wget -O allure.zip https://github.com/allure-framework/allure2/releases/download/${ALLURE_VERSION}/allure-${ALLURE_VERSION}.zip
RUN unzip allure.zip && rm allure.zip
RUN mv allure-${ALLURE_VERSION} allure

ENV ALLURE_HOME /home/jenkins/allure

ENTRYPOINT ["jenkins-slave"]