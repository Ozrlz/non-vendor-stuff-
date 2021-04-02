FROM python:3.6.5

WORKDIR /home/code
COPY requirements.txt .
RUN pip install -r requirements.txt
ENV DEBUG_METRICS=true

COPY main.py .

ENTRYPOINT ["python", "main.py"]