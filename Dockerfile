FROM centos:centos7

#RUN rpm -Uvh https://yum.postgresql.org/11/redhat/rhel-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN rpm -Uvh https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm

RUN yum -y update; yum clean all
RUN yum -y install sudo epel-release; yum clean all
RUN yum -y install postgresql11-server postgresql11 postgresql11-contrib supervisor pwgen wget python36  rsync findutils procps vim lsof iputils openssl curl fontconfig tar unzip; yum clean all

ADD ./postgresql-setup /usr/bin/postgresql-setup
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./start_postgres.sh /start_postgres.sh

#Sudo requires a tty. fix that.
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers
RUN chmod +x /usr/pgsql-11/bin/postgresql-11-setup
RUN chmod +x /start_postgres.sh

#RUN ls -l /usr/
#RUN ls -l /usr/bin/
#RUN /usr/pgsql-11/bin/postgresql-11-setup initdb

ADD ./postgresql.conf /var/lib/pgsql/data/postgresql.conf

RUN chown -v postgres.postgres /var/lib/pgsql/data/postgresql.conf

#RUN echo "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/data/pg_hba.conf

VOLUME ["/var/lib/pgsql"]

#EXPOSE 5432

#CMD ["/bin/bash", "/start_postgres.sh"]
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
