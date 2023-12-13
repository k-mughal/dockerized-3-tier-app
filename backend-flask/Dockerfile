# base image
FROM python:3.8-slim

# working directory inside the container
WORKDIR /app

# Copy the all local requirements to the container
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the local application code to the created container
COPY . .

# Expose the port where Flask app will run
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py", "--host=0.0.0.0", "--port=5000"]
