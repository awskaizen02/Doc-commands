FROM centos:7
 
COPY yum.repos.d /etc/yum.repos.d/CentOS-Base.repo
 
ARG user=application
 
LABEL maintainer=raja
LABEL vendor=Kaizen
 
WORKDIR /var/www/html/
 
ENV LINK=https://www.free-css.com/assets/files/free-css-templates/download/page292/settle.zip
 
RUN yum update -y
 
RUN yum -y install httpd unzip wget
 
ADD $LINK .
 
RUN unzip settle.zip && mv settle-html/* .
 
RUN useradd $user && chown $user:$user -R .
 
RUN rm -rf settle.zip  settle-html/
 
USER root
 
COPY cmd.sh /cmd.sh
 
RUN chmod +x /cmd.sh
 
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
