FROM python:3.7-alpine

RUN adduser -D server

WORKDIR /home/server

RUN apk add gcc g++ make python3-dev libc6-compat musl-dev postgresql-dev postgresql-libs

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt

COPY server server
COPY startServer.sh ./
RUN chmod +x startServer.sh

RUN chown -R server:server ./
USER server

EXPOSE 50101
ENTRYPOINT ["./startServer.sh"]
