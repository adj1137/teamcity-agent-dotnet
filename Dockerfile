# Start from the JetBrains TeamCity agent base image
FROM jetbrains/teamcity-agent:latest

# Set environment variables for .NET installation
ENV DOTNET_VERSION 8.0

# Install dependencies and .NET SDK
RUN apt-get update && \
    apt-get install -y wget apt-transport-https && \
    wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -cs)/prod.list && \
    mv prod.list /etc/apt/sources.list.d/mssql-prod.list && \
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y dotnet-sdk-${DOTNET_VERSION} && \
    apt-get clean

# Verify the installation
RUN dotnet --version

# Set the working directory (optional, depending on your needs)
WORKDIR /data

# Default command
CMD ["bash"]
