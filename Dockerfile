FROM ubuntu:rolling
USER root

# Install some Debian package
RUN apt-get update && apt-get install -y --no-install-recommends \
    python*-setuptools     \
    python*-wheel          \
    python*-pip            \
    less                  \
    nano                  \
    sudo                  \
    git                   \
    npm                   \
    fftw3                 \
  && rm -rf /var/lib/apt/lists/*

# install Jupyter via pip
RUN pip2 install jupyter-notebook
RUN pip2 install notebook

# install ipywidgets
RUN pip2 install ipywidgets  && \
    jupyter nbextension enable --sys-prefix --py widgetsnbextension

# install Appmode
COPY . /opt/appmode
WORKDIR /opt/appmode/
RUN pip2 install .                                           && \
    jupyter nbextension     enable --py --sys-prefix appmode && \
    jupyter serverextension enable --py --sys-prefix appmode

# Launch Notebook server
EXPOSE 8888
CMD ["jupyter-notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.token=''"]

#EOF
