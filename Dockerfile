FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements.txt from the subdirectory
COPY django-on-ec2-develop/requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

# Copy the actual Django project into /app
COPY django-on-ec2-develop/ /app/

# Collect static files
RUN python manage.py collectstatic --noinput

EXPOSE 80

CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]
