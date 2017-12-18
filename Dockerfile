FROM ubuntu

RUN apt-get update && apt-get install -y collectd

RUN apt-get install -y unzip git wget curl jq libunwind-dev libcurl3 && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -yq nodejs && \
    npm install npm -g

COPY SignalR /home/SignalR

WORKDIR /home/SignalR

RUN ./build.sh || echo "Test failed"

RUN ln -s /root/.dotnet/dotnet /usr/bin/dotnet

COPY collectd.conf /etc/collectd/collectd.conf.d/my.conf

COPY types.db /usr/share/collectd/types.db

COPY run.sh /run.sh

EXPOSE 5001

CMD ["/bin/bash", "/run.sh"]
