FROM python:2.7.12-alpine
RUN wget -O- "http://s3.amazonaws.com/babl/babl-server_linux_amd64.gz" | gunzip > /bin/babl-server && chmod +x /bin/babl-server
ADD app /data/
RUN ln -s /data/app /bin/app
RUN chmod +x /bin/app
WORKDIR /data
RUN pip install -U pip
RUN pip install dropbox
CMD ["babl-server"]
