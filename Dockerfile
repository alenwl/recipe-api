FROM python:3.10-alpine

LABEL maintainer="alc00277@gmail.com"

# Recommended for python:3.10-alpine container
ENV PYTHONUNBUFFERED 1

# Copy requirements txt and install modules
COPY ./requirements.txt /requirements.txt
# Install required modules
RUN apk add --update --no-cache postgresql-client jpeg-dev
# Install temoporary dependencies 
RUN apk add --update --no-cache --virtual .tmp-build-deps \
    gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
# Install modules in requiremenets.txt and remove tempotary dependencies
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

# Create directory for app and copy files
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# Create storage for media and static files
RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
# Update permissions for user
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
# Switch to user
USER user