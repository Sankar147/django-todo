# Use official lightweight Python image
FROM python:3.11-slim
 
# Set working directory
WORKDIR /app
 
# Prevent Python from writing .pyc files and using stdout buffering
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
 
# Install system dependencies (for building some Python packages if needed)
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*
 
# Copy requirements first (for better caching)
COPY requirements.txt /app/
 
# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt
 
# Copy the rest of the project
COPY . /app/
 
# Collect static files (so CSS/JS/images work)
RUN python manage.py collectstatic --noinput
 
# Expose Django's default port
EXPOSE 8000
 
# Run Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
