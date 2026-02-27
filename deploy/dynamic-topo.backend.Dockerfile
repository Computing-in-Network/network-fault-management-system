FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY components/dynamic-topo/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY components/dynamic-topo/dynamic_topo ./dynamic_topo
COPY components/dynamic-topo/pyproject.toml ./pyproject.toml

EXPOSE 8765

CMD ["python", "-m", "dynamic_topo.stream_server", "--host", "0.0.0.0", "--port", "8765", "--dt", "1.0"]
