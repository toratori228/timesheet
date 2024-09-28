# Use the official Python base image
FROM python:3.9-slim-buster
EXPOSE 5000
# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1


WORKDIR /srv
ADD timesheet/ ./timesheet
COPY Pipfile Pipfile.lock ./

# Install pip requirements
ADD Pipfile .
RUN pip3 install --upgrade pip && \
    pip3 install pipenv

# Copy requirements.txt to the working directory
COPY requirements.txt ./

# Install dependencies using pip
RUN pip3 install --upgrade pip && \
    pip3 install -r requirements.txt    


RUN pipenv install --python $(which python3.9)
# Install gunicorn globally
RUN pip install gunicorn
RUN pip install Flask

RUN useradd appuser && chown -R appuser ./timesheet
USER appuser


# During debugging, this entry point will be overridden. For more information, please refer to https://aka.ms/vscode-docker-python-debug
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "timesheet.app:create_app()"]
