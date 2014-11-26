FROM ubuntu:14.04
MAINTAINER Bence Kiglics <bence.kiglics@gmail.com>

RUN apt-get update -y
RUN apt-get install -y curl
RUN curl -sSL https://get.rvm.io | bash
RUN /bin/bash -l -c "rvm install ruby-2.1.4"

RUN mkdir /opt/jenkins-dashboard
COPY . /opt/jenkins-dashboard/
RUN /bin/bash -l -c "cd /opt/jenkins-dashboard && bundle"

EXPOSE 8080
WORKDIR /opt/jenkins-dashboard
CMD ["/bin/bash", "-l", "-c", "rvm use 2.1.4 && rerun rackup"]

