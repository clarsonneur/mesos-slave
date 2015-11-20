FROM clarsonneur/centos-systemd:7

RUN rpm -i http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm && \
yum -y install mesos-0.25.0 && yum clean all ; \
systemctl disable mesos-master ; systemctl enable mesos-slave ; > /etc/default/mesos-slave ; rm -f /etc/mesos/zk

# http://docs.docker.com/installation/centos/
RUN curl -fLsS https://get.docker.com/ | sh ; yum clean all

ENV MESOS_WORK_DIR=/tmp/mesos MESOS_CONTAINERIZERS=docker,mesos MESOS_EXECUTOR_REGISTRATION_TIMEOUT=5mins

# https://mesosphere.github.io/marathon/docs/native-docker.html
# ENV MESOS_EXECUTOR_REGISTRATION_TIMEOUT 5mins

VOLUME /tmp/mesos

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD /usr/sbin/init
