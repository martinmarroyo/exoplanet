FROM python:3.9
# Update current packages
RUN apt-get update && apt-get upgrade -y && \
apt-get install -y ssh netcat iputils-ping && \
mkdir ../var/run/sshd && \
chmod 0755 ../var/run/sshd && \
useradd -p $(openssl passwd -1 exoplanet) --create-home --shell /bin/bash --groups sudo exoplanet
WORKDIR /warehouse
COPY . .
RUN pip install -r requirements.txt
RUN mkdir -p logs && touch logs/warehouse.log && chmod a+rwx logs/warehouse.log
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]