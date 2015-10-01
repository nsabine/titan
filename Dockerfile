FROM rhel7

MAINTAINER Nick Sabine <nsabine@redhat.com>

RUN yum install -y java-1.8.0-openjdk curl unzip && yum clean all

ENV TITAN_VERSION 0.5.4-hadoop2
ENV TITAN_HOME /opt/titan-0.5.4-hadoop2/
ENV TITAN_PROPERTIES=/opt/titan-0.5.4-hadoop2/titan.properties

RUN curl -o /opt/titan.zip http://s3.thinkaurelius.com/downloads/titan/titan-0.5.4-hadoop2.zip &&\
    unzip /opt/titan.zip -d /opt/ &&\
    rm -f /opt/titan.zip

WORKDIR /opt/titan-0.5.4-hadoop2/

ADD run.sh /opt/titan-0.5.4-hadoop2/
ADD rexster-titan.xml.template /opt/titan-0.5.4-hadoop2/
RUN chmod +x /opt/titan-0.5.4-hadoop2/run.sh
RUN find /opt -type f -exec chmod a+rw {} \;
RUN find /opt -type d -exec chmod a+rwx {} \;

EXPOSE 8182
EXPOSE 8183
EXPOSE 8184

CMD ["/bin/sh", "-c", "/opt/titan-0.5.4-hadoop2/run.sh"]

