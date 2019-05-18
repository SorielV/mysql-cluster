# Copyright (c) 2017, 2018, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

FROM oraclelinux:7-slim

ARG MYSQL_CLUSTER_PACKAGE=mysql-cluster-community-server-minimal-7.5.13
ARG MYSQL_SHELL_PACKAGE=mysql-shell-8.0.14

# Install server
RUN yum install -y \
    https://repo.mysql.com/mysql-cluster-community-minimal-release-el7.rpm \
    https://repo.mysql.com/mysql-community-release-el7.rpm \
  && yum-config-manager --enable mysql-cluster75-minimal \
  && yum install -y \
    $MYSQL_CLUSTER_PACKAGE \
    $MYSQL_SHELL_PACKAGE \
    libpwquality \
  && yum clean all \
  && mkdir /docker-entrypoint-initdb.d

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /entrypoint.sh
COPY healthcheck.sh /healthcheck.sh
COPY cnf/my.cnf /etc/
COPY cnf/mysql-cluster.cnf /etc/

ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 3306 33060 2202 1186
HEALTHCHECK CMD /healthcheck.sh
CMD ["mysqld"]

