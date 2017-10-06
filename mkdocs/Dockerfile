FROM 3-alpine
MAINTAINER Minh-Quan TRAN <account@itscaro.me>

WORKDIR /tmp

COPY requirements.txt setup.py ./
RUN \
  pip install -r requirements.txt && \
  rm requirements.txt

RUN \
  python setup.py install && \
  rm -rf /tmp/*

WORKDIR /docs

EXPOSE 8000

ENTRYPOINT ["mkdocs"]

CMD ["serve", "--dev-addr=0.0.0.0:8000"]
