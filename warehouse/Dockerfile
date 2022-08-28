FROM alpine:3.16
# Update current packages
RUN apk update && apk upgrade
# Install required programs
RUN apk add python3 py3-pip
WORKDIR /warehouse
COPY . .
RUN pip install -r requirements.txt
CMD ["python3", "init_warehouse.py"]