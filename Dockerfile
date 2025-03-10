FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa -y
ARG DEBIAN_FRONTEND="noninteractive"
ENV TZ=America/Chicago
RUN apt-get update

RUN apt-get install -y \
    python3.12 python3.12-dev python3.12-venv \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1 \
    && python -m ensurepip --upgrade \
    && rm -rf /var/lib/apt/lists/*


# Set working directory
WORKDIR /app

# Copy only the requirements file first
COPY requirements.txt .

# Install dependencies using uv
RUN pip3.12 install -r requirements.txt

# Copy the rest of the application
COPY . .
