FROM redis:7

RUN groupadd -g {{ $dockerUserUid }} {{ $dockerUsername }} && useradd -u {{ $dockerUserUid }} -ms /bin/bash -g {{ $dockerUsername }} {{ $dockerUsername }}

RUN chown {{ $dockerUsername }}:{{ $dockerUsername }} /data

USER {{ $dockerUsername }}

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]

CMD ["redis-server"]
