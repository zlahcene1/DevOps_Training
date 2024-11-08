FROM jenkins/jenkins:latest
WORKDIR .
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false -Dpermissive-script-security.enabled=true"
COPY plugins.txt plugins.txt
RUN pip install -r plugin.txt