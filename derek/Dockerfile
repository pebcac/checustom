FROM ubi8:latest
LABEL maintainer="Derek Walker dewalker@redhat.com"
USER root
RUN yum update -y && yum install -y java-1.8.0-openjdk procps-ng && yum -y autoremove &&yum clean all
CMD ["bash"]
