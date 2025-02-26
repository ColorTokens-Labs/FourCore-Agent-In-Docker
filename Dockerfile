FROM ubuntu:20.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install rsyslog and supervisor
RUN apt-get update && apt-get install -y \
    rsyslog \
    supervisor \
    iproute2 \
    net-tools \
    iputils-ping \
    libpcap0.8 \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy Supervisor configuration into the container
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy the Linux FourCore ATTACK agent into the container
COPY agent /usr/local/bin/agent
RUN chmod +x /usr/local/bin/agent

# Launch rsyslog and the agent
CMD ["/usr/bin/supervisord", "-n"]
