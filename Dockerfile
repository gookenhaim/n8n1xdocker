FROM node:22-bookworm-slim
USER root

RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv \
    build-essential \
    graphicsmagick \
    && rm -rf /var/lib/apt/lists/*

# n8n 1.123.61 설치
RUN npm install -g n8n@1.123.61

# Python Function 커뮤니티 노드
RUN npm install -g n8n-nodes-python

# Python 패키지 (debian이라 pandas/lxml 미리 빌드된 wheel로 깔림 — 컴파일 없음)
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --break-system-packages --no-cache-dir -r /tmp/requirements.txt \
    && rm /tmp/requirements.txt

ENV N8N_PORT=5678
EXPOSE 5678
CMD ["n8n"]
