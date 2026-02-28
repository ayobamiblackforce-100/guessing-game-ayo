FROM python:3.10

WORKDIR /app/

COPY /app/* /app/

RUN pip install requirements.txt

CMD ['streamlit', 'run', 'app.py']
