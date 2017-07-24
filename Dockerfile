FROM centos:6
MAINTAINER rmkn
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8 && sed -i -e "s/en_US.UTF-8/ja_JP.UTF-8/" /etc/sysconfig/i18n
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime && echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
RUN yum -y update
RUN yum -y install epel-release
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum -y install --enablerepo=remi-php71 httpd php php-mbstring

COPY security.sh /tmp/security.sh
RUN /tmp/security.sh && rm /tmp/security.sh

RUN sed -i -e 's/;date.timezone =/date.timezone = Asia\/Tokyo/' /etc/php.ini

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

