FROM mysql:8.0.27

RUN groupadd -g {{ $dockerUserUid }} {{ $dockerUsername }} && useradd -u {{ $dockerUserUid }} -ms /bin/bash -g {{ $dockerUsername }} {{ $dockerUsername }}

RUN chown -R {{ $dockerUsername }}:{{ $dockerUsername }} /var/lib/mysql /var/run/mysqld \
    && chmod 1777 /var/run/mysqld /var/lib/mysql

USER {{ $dockerUsername }}

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]

CMD ["mysqld"]
