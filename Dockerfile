FROM rhel7

MAINTAINER Nick Sabine <nsabine@redhat.com>

RUN yum install -y java-1.8.0-openjdk curl unzip && yum clean all

ENV TITAN_VERSION 1.0.0-hadoop1
ENV TITAN_HOME /opt/titan-$TITAN_VERSION/
ENV TITAN_PROPERTIES=$TITAN_HOME/titan.properties

RUN curl -o /opt/titan.zip http://s3.thinkaurelius.com/downloads/titan/titan-$TITAN_VERSION.zip &&\
    unzip /opt/titan.zip -d /opt/ &&\
    rm -f /opt/titan.zip

WORKDIR $TITAN_HOME

ADD run.sh $TITAN_HOME

EXPOSE 8182
EXPOSE 8183
EXPOSE 8184

CMD ["/bin/sh", "-e", "$TITAN_HOME/run.sh"]

