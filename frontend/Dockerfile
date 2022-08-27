FROM alpine:3.16
# Update current packages
RUN apk update && apk upgrade
# Install required programs
RUN apk add python3 py3-pip nano curl wget git \
github-cli openssh-keygen bash dropbear-dbclient
# Generate SSH key to connect to Github
RUN ssh-keygen -t rsa -f ~/.ssh/git-key -q -N '""'
WORKDIR /exoplanet
COPY logo.txt .
# Show the logo and keep the container running
ENV ENV="/etc/profile"
RUN echo "cat /exoplanet/logo.txt" >> "$ENV"
CMD ["tail", "-f", "/dev/null"]