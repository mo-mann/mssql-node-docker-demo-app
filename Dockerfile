# FROM microsoft/mssql-server-linux:latest
FROM mcr.microsoft.com/mssql/server:2017-latest-ubuntu

# Install node/npm
RUN apt-get -y update  && \
        apt-get install -y curl && \
        curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
        apt-get install -y nodejs

# Install tedious, the driver for SQL Server for Node.js
RUN npm install tedious

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

# Grant permissions for the import-data script to be executable
RUN chmod +x /usr/src/app/import-data.sh

EXPOSE 9000

CMD /bin/bash ./entrypoint.sh