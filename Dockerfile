FROM centos:6
MAINTAINER rmkn
RUN yum -y update
RUN yum -y install epel-release
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum -y install --enablerepo=remi,remi-php70 httpd php70-php php70-php-mbstring unzip

COPY security.sh /tmp/security.sh
RUN /tmp/security.sh && rm /tmp/security.sh

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

