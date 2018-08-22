FROM php:7.0.10-fpm
 
#Install Cron
RUN apt-get update
RUN apt-get -y install cron

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/hello-cron
# Give execution rights on the cron job
RUN chmod +x /etc/cron.d/hello-cron
RUN crontab /etc/cron.d/hello-cron
# Run the command on container startup
CMD crontab && tail -f /var/log/cron.log
# CMD php-fpm
CMD ["cron", "-f"]

