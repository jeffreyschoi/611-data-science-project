FROM rocker/verse

RUN apt update && \
    apt install -y man-db manpages && \
    yes | unminimize && rm -rf /var/lib/apt/lists/*
