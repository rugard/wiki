FROM python:2.7

COPY cgi-bin /opt/cgi-bin

RUN chmod +x /opt/cgi-bin/testpy

WORKDIR /opt

ENTRYPOINT ['']
CMD ['nsenter -t 1 -m -u -n -i sh -c '/usr/bin/python -m CGIHTTPServer'']

#CMD ['python -m CGIHTTPServer']
