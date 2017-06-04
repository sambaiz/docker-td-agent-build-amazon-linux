FROM amazonlinux:2017.03

WORKDIR /tmp

RUN yum -y update && \
    yum groupinstall -y "Development Tools" && \
    yum install -y ruby23 ruby23-devel && \
    gem install bundler io-console && \
    git clone https://github.com/treasure-data/omnibus-td-agent

WORKDIR /tmp/omnibus-td-agent

RUN bundle install --binstubs && \
    bin/gem_downloader core_gems.rb && \
    bin/gem_downloader plugin_gems.rb && \
    bin/gem_downloader ui_gems.rb && \
    mkdir -p /opt/td-agent /var/cache/omnibus && \
    bin/omnibus build td-agent2 && \
    mv ./pkg/*.rpm /
