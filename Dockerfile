FROM registry.access.redhat.com/ubi8/ubi-minimal

USER root
RUN microdnf update
# Useful things IBM recommended plus 2 from Atlassian (fontconfig and jinja2)

RUN microdnf update
RUN microdnf install -y  python36  rsync findutils procps vim lsof iputils openssl curl fontconfig tar unzip \
#RUN yum update --disablerepo=* --enablerepo=ubi-8-appstream --enablerepo=ubi-8-baseos -y && rm -rf /var/cache/yum
#RUN yum install --disablerepo=* --enablerepo=ubi-8-appstream --enablerepo=ubi-8-baseos httpd -y && rm -rf /var/cache/yum
#RUN yum install -y  python36 postgresql10 rsync findutils procps vim lsof iputils openssl curl fontconfig tar unzip \
#                        python3-jinja2 shadow-utils
RUN microdnf clean all && [ ! -d /var/cache/yum ] || rm -rf /var/cache/yum

RUN touch /var/www/html/index.html
RUN echo "The Web Server is Running" > /var/www/html/index.html
EXPOSE 8080 
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
USER 1001:1001  
