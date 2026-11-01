# SQL Server with a pre-seeded sample database (chapter 8).
# The SA password is passed at build time; do not push images built with a real password.
FROM mcr.microsoft.com/mssql/server:2022-latest

ARG MSSQL_SA_PASSWORD
ENV ACCEPT_EULA=Y
ENV MSSQL_SA_PASSWORD=${MSSQL_SA_PASSWORD}

WORKDIR /src
COPY --chown=mssql:root scripts.sql ./scripts.sql

# Start SQL Server during the build, wait until it accepts connections, then run scripts.sql
RUN /opt/mssql/bin/sqlservr & \
    for i in $(seq 1 60); do \
      /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -Q "SELECT 1" >/dev/null 2>&1 && break; \
      sleep 2; \
    done && \
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -i scripts.sql && \
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -Q "SHUTDOWN WITH NOWAIT"; sleep 3
