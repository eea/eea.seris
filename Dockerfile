FROM eeacms/python:2.7-slim
RUN echo "deb http://archive.debian.org/debian/ jessie main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security jessie/updates main contrib non-free" >> /etc/apt/sources.list

# Copy code into image
RUN mkdir seris
COPY requirements.txt requirements-dev.txt /seris/
WORKDIR seris

# Install requirements
RUN apt-get update && apt-get install -y --force-yes git \
  && pip install -r requirements-dev.txt

# Copy code
COPY . /seris
COPY ./instance/settings-docker.py ./instance/settings.py

# Expose needed port
EXPOSE 5000

#Default command
CMD ["./docker-entrypoint.sh"]
