FROM alpine:3.12
COPY ./entrypoint.sh /
RUN apk add --no-cache bc coreutils && dos2unix /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "-r", "100", "5000" ]
