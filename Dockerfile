FROM python:3.7-slim

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME

# Install production dependencies.
COPY requirements.txt .
RUN pip install gunicorn functions-framework
RUN pip install -r requirements.txt

COPY . .
# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 -e FUNCTION_TARGET=route_request functions_framework:app
