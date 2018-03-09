# openthinclient-suite inside Docker
FROM univention/ucs-appbox-amd64:latest
ENV DEBIAN_FRONTEND noninteractive

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get update && apt-get install -y \    
    oracle-java8-installer \
    oracle-java8-set-default \
    libxrender1 \
    libxtst6

ADD http://downloads.sourceforge.net/project/openthinclient/installer/openthinclient-2.1-Pales.jar?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fopenthinclient%2F&ts=1450570667&use_mirror=skylink /tmp/data/
ADD https://raw.githubusercontent.com/openthinclient/docker-uv/develop/data/openthinclient-installer.sh /tmp/data/
ADD https://raw.githubusercontent.com/openthinclient/docker-uv/develop/data/start.sh /etc/init.d/otc-start.sh

## Local source
#ADD data/openthinclient-2.1-Pales.jar /tmp/data
#ADD data/start.sh /tmp/data/start.sh
#ADD data/openthinclient-installer.sh

RUN sh /tmp/data/openthinclient-installer.sh
RUN rm -rf /tmp/data/
RUN chmod 0755 /etc/init.d/otc-start.sh

ENTRYPOINT ["bash","/etc/init.d/otc-start.sh"]

