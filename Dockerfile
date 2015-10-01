FROM rhel7

MAINTAINER Nick Sabine <nsabine@redhat.com>

RUN yum install -y java-1.8.0-openjdk curl unzip && yum clean all

ENV TITAN_VERSION 1.0.0-hadoop1
ENV TITAN_HOME /opt/titan-1.0.0-hadoop1/
ENV TITAN_PROPERTIES=/opt/titan-1.0.0-hadoop1/titan.properties

RUN curl -o /opt/titan.zip http://s3.thinkaurelius.com/downloads/titan/titan-1.0.0-hadoop1.zip &&\
    unzip /opt/titan.zip -d /opt/ &&\
    rm -f /opt/titan.zip

WORKDIR /opt/titan-1.0.0-hadoop1/

ADD run.sh /opt/titan-1.0.0-hadoop1/

EXPOSE 8182
EXPOSE 8183
EXPOSE 8184

CMD ["/bin/sh", "-c", "/opt/titan-1.0.0-hadoop1/run.sh"]

