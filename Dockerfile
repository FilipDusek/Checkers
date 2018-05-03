FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ./app/ .

ENV FLASK_APP=./app/main.py
ENV FLASK_DEBUG=1

CMD ["flask", "run", "--host=0.0.0.0"]
