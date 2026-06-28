FROM n8nio/n8n:1.123.61
USER root

# Python + pandas/lxml 컴파일에 필요한 빌드 도구
RUN apk add --update --no-cache \
    python3 \
    py3-pip \
    build-base \
    python3-dev \
    gfortran \
    openblas-dev \
    libxml2-dev \
    libxslt-dev

# Python Function 커뮤니티 노드
RUN cd /usr/local/lib/node_modules/n8n && npm install n8n-nodes-python

# 패키지 영구 설치
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --break-system-packages --no-cache-dir -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt

USER node
