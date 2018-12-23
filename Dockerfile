FROM python:3.7-alpine3.8

COPY s3cfg start.sh /

RUN apk update \
  && apk add --no-cache libmagic \
  && pip install s3cmd \
  && mv /s3cfg /root/.s3cfg

ENTRYPOINT ["/start.sh"]
CMD [""]
