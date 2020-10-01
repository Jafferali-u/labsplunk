#!/bin/bash
# To setup indexers
id splunk >/dev/null 2>&1 || useradd splunk &&
    wget -O /tmp/splunk-8.0.6-152fb4b2bb96-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=8.0.6&product=splunk&filename=splunk-8.0.6-152fb4b2bb96-Linux-x86_64.tgz&wget=true' &&
    tar -xf /tmp/splunk-8.0.6-152fb4b2bb96-Linux-x86_64.tgz -C /opt &&
    chown -R splunk:splunk /opt/splunk &&
    /opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt --seed-passwd password && sleep 10 &&
    /opt/splunk/bin/splunk edit cluster-config -mode slave -master_uri https://34.123.153.129:8089 -replication_port 9887 -secret password -auth admin:password &&
    /opt/splunk/bin/splunk edit licenser-localslave -master_uri https://34.122.3.154:8089 -auth admin:password &&
    /opt/splunk/bin/splunk restart
