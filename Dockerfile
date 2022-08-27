FROM python:3.9
WORKDIR /src
ENV PYTHONPATH=/src
RUN apt get update && apt get upgrade -y && \
apt get install -y ssh netcat iputils-ping && \
mkdir ../var/run/sshd && \
chmod 0755 ../var/run/sshd && \
useradd -p $(openssl passwd -1 exoplanet) --create-home --shell /bin/bash --groups sudo exoplanet
EXPOSE 22
COPY etl /src/etl
COPY requirements.txt .
COPY main.py .
COPY config.yml .
CMD ["/usr/sbin/sshd", "-D"]

