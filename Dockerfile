FROM python:3.11.2

RUN groupadd clamav \
    && useradd --create-home -g clamav -s /bin/false -c "Clam Antivirus" clamav \
    && mkdir -m 0770 -p /var/lib/fangfrisch /var/lib/clamav \
    && chgrp clamav /var/lib/fangfrisch /var/lib/clamav

WORKDIR /var/lib/fangfrisch
USER clamav

COPY fangfrisch.conf /etc/fangfrisch.conf

SHELL ["/bin/bash", "-c"]
RUN python3 -m venv venv \
    && source venv/bin/activate \
    && pip install --pre fangfrisch==1.6.0.dev1 \
    && venv/bin/fangfrisch --conf /etc/fangfrisch.conf initdb

COPY entrypoint.sh .

ENTRYPOINT ["bash", "entrypoint.sh"]
