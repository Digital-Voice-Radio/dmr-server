###############################################################################
# Copyright (C) 2025 Jared Quinn, VK2WAY <jaredquinn@gmail.com>
# Copyright (C) 2020 Simon Adlem, G7RZU <g7rzu@gb7fr.org.uk>  
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software Foundation,
#   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
###############################################################################
FROM python:3.9-alpine

ENTRYPOINT [ "/entrypoint" ]

COPY requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt
RUN pip install supervisor


RUN adduser -D -u 54000 radio
RUN mkdir -p /opt/dmr 

WORKDIR /opt/dmr

COPY . /opt/dmr

RUN chown -R radio /opt/dmr

RUN chmod a+rx playback.py hotspot_proxy_v2.py bridge_master.py

COPY docker/supervisord.conf /etc/supervisord.conf
COPY docker/entrypoint-proxy /entrypoint
USER radio

