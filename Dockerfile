FROM selenium/node-firefox:3.141.59-20200409

ENV USER=seluser

USER $USER:$USER

WORKDIR /home/$USER

# copy all files from current directory
COPY --chown=$USER:$USER ./*\.* ./

# install pip
RUN sudo apt-get update && sudo apt-get -y install python3-pip
RUN python3 -m pip install --upgrade pip

RUN sudo apt-get -y install git

RUN python3 -m pip install -U setuptools

RUN python3 -m pip install -r requirements.txt

RUN python3 -m pip install git+https://github.com/OlehOnyshchak/RedditScore.git

# TODO: try to workaround because mounted drive has root owner
CMD (chown $USER data; python3 main.py)