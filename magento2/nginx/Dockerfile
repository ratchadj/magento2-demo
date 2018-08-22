FROM nginx:latest

RUN apt-get update \
	&& apt-get install curl sudo git -y \
	&& curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.1.2-amd64.deb \
	&& sudo dpkg -i filebeat-5.1.2-amd64.deb \
	&& rm -rf /var/log/nginx/*.log \
	&& touch /var/log/nginx/access.log \
	&& touch /var/log/nginx/error.log

ADD ./start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh
CMD [ "/usr/local/bin/start.sh" ]
