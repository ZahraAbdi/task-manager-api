# Use official Python image
FROM python:3.13-slim

# Set work directory
WORKDIR /code

# Install dependencies
COPY requirements.txt .

# Upgrade pip and install setuptools and wheel
RUN pip install --upgrade pip setuptools wheel

# Install Python requirements
RUN pip install -r requirements.txt

# Install curl and download wait-for-it.sh
RUN apt-get update && apt-get install -y curl && \
    curl -o /wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
    chmod +x /wait-for-it.sh && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Expose port
EXPOSE 8000

# Start Django, waiting for Postgres
CMD ["/wait-for-it.sh", "db:5432", "--timeout=60", "--strict", "--", "python", "manage.py", "runserver", "0.0.0.0:8000"]
