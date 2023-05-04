FROM python:3.9-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN pip install --no-cache-dir werkzeug==2.2.3 flask==2.2.4 requests rsa geoip2 bcrypt

WORKDIR /app
EXPOSE 80
CMD [ "python", "./main.py", "serve" ]
