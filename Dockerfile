FROM registry.access.redhat.com/ubi8/ubi-minimal

USER root
RUN microdnf update
# Useful things IBM recommended plus 2 from Atlassian (fontconfig and jinja2)

#RUN microdnf install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN microdnf update
RUN microdnf install -y sudo epel-release; yum clean all
RUN microdnf install -y postgresql postgresql-contrib  pwgen; yum clean all
RUN microdnf install -y  wget python36  rsync findutils procps vim lsof iputils openssl curl fontconfig tar unzip 
RUN microdnf clean all && [ ! -d /var/cache/yum ] || rm -rf /var/cache/yum

#RUN microdnf install -y postgresql10-server
#RUN /usr/pgsql-10/bin/postgresql-10-setup initdb

EXPOSE 8080 
#CMD ["-D", "FOREGROUND"]
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
#ENTRYPOINT ["/usr/sbin/httpd"]
USER 1001:1001  
