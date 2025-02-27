FROM python:3-slim

WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt
COPY main.py /app/

ENTRYPOINT ["python", "/app/main.py"]
