FROM centos:6
MAINTAINER rmkn
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime && echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock
RUN yum -y update
RUN yum -y install epel-release
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum -y install --enablerepo=remi,remi-php70 httpd php70-php php70-php-mbstring

COPY security.sh /tmp/security.sh
RUN /tmp/security.sh && rm /tmp/security.sh

RUN sed -i -e 's/;date.timezone =/date.timezone = Asia\/Tokyo/' /etc/opt/remi/php70/php.ini

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

