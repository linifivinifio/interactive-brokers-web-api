FROM debian:bookworm-slim

# Update and upgrade packages
RUN apt-get update && apt-get upgrade -y

# Install JDK, Python, and utilities
RUN apt-get install -y openjdk-17-jre-headless \
                       unzip curl procps vim net-tools \
                       python3 python3-pip

# We will put everything in the /app directory
WORKDIR /app

# Download and unzip client portal gateway
RUN mkdir gateway && cd gateway && \
    curl -O https://download2.interactivebrokers.com/portal/clientportal.gw.zip && \
    unzip clientportal.gw.zip && rm clientportal.gw.zip

# Copy our configuration and scripts
COPY conf.yaml gateway/root/conf.yaml
COPY start.sh /app

# Add web application and scripts
ADD webapp webapp
ADD scripts scripts

# Install Python dependencies globally
RUN pip3 install flask requests --break-system-packages

# Expose ports
EXPOSE 5055 5056

# Run the gateway
CMD sh ./start.sh