# peeringdb
# reference: https://medium.com/zeitcode/a-simple-recipe-for-django-development-in-docker-bonus-testing-with-selenium-6a038ec19ba5
# author: Jerome Fleury
FROM python:2
# Install Python and Package Libraries
RUN apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean
RUN apt-get install -y \
    libffi-dev \
    libssl-dev \
    default-libmysqlclient-dev \
    libxml2-dev \
    libxslt-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    net-tools \
    vim
# Project Files and Settings
ARG PROJECT=peeringdb
ARG PROJECT_DIR=/var/www/${PROJECT}
RUN mkdir -p $PROJECT_DIR
WORKDIR $PROJECT_DIR
#COPY Pipfile Pipfile.lock ./
#RUN pip install -U pipenv
#RUN pipenv install --system
COPY requirements.txt .
RUN pip install -r requirements.txt
# Server
EXPOSE 8000
STOPSIGNAL SIGINT
ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8000"]
