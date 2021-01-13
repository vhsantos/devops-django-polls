
# We are creating the image using python and alpine (to reduce the size)
FROM python:3.9.1-alpine3.12

# Add the requeriments files. I have add 02 extra dependences (gunicorn and psycopg2)
ADD devops-hiring/requirements.txt /app/requirements.txt

# We install all the softwares and depences inside a virtual enviroment
RUN set -ex \
    && apk add --no-cache --virtual .build-deps postgresql-dev build-base \
    && python -m venv /env \
    && /env/bin/pip install --upgrade pip \
    && /env/bin/pip install --no-cache-dir -r /app/requirements.txt \
    && runDeps="$(scanelf --needed --nobanner --recursive /env \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u \
        | xargs -r apk info --installed \
        | sort -u)" \
    && apk add --virtual rundeps $runDeps \
    && apk del .build-deps

# Copy the repository to the directory /app
ADD devops-hiring /app
WORKDIR /app

# Setup enviroments and paths
ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH

# port tcp 8000 published
EXPOSE 8000

# Command to run gunicorn on port 8000/tcp with 4 workers.
CMD ["gunicorn", "--bind", ":8000", "--workers", "4", "mysite.wsgi"]
