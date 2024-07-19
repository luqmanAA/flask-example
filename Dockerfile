FROM python:3.11

RUN mkdir -p /home/app

# create the app user
RUN addgroup app && adduser --system --no-create-home app --ingroup app

# create the appropriate directories
#ENV HOME=/home/app

ENV APP_HOME=/home/app/

WORKDIR $APP_HOME

# Upgrade packages
RUN apt-get update && apt-get upgrade -y

# Copy Code Files
COPY . $APP_HOME

# install dependencies
RUN pip install --upgrade pip

RUN pip install -r requirements.txt

# chown all the files to the app user
RUN chown -R app:app $APP_HOME

# change to the app user
USER app

CMD [ "python", "main.py" ]
