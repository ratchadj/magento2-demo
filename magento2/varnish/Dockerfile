FROM ubuntu:14.04.1

RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get -y install varnish && \
  apt-get -y clean

# Make our custom VCLs available on the container
ADD default.vcl /etc/varnish/default.vcl

ENV VARNISH_PORT 80

# Expose port 80
EXPOSE 80

# ADD start.sh /start.sh
# CMD ["/start.sh"]
ADD ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
CMD [ "/usr/local/bin/start.sh" ]
