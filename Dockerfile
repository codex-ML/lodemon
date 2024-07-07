FROM nikolaik/python-nodejs:python3.10-nodejs19

# Update the package list and install ffmpeg
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Check if Node.js version is 16 or higher, if not install Node.js through apt
RUN if ! node -v | grep -E '^v(1[6-9]|[2-9][0-9])\.'; then \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*; \
    fi

# Copy your application files to the /app directory
COPY . /app/

# Set the working directory to /app
WORKDIR /app/

# Install Python dependencies
RUN pip3 install --no-cache-dir -U -r requirements.txt

# Specify the default command to run
CMD bash start
