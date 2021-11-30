FROM continuumio/anaconda3

RUN apt-get update && apt-get install -y libgtk2.0-dev && \
    rm -rf /var/lib/apt/lists/*

RUN /opt/conda/bin/conda update -n base -c defaults conda && \
    /opt/conda/bin/conda install python=3.6 && \
    /opt/conda/bin/conda install anaconda-client && \
    /opt/conda/bin/conda install jupyter -y && \
    /opt/conda/bin/conda install --channel https://conda.anaconda.org/menpo opencv3 -y && \
    /opt/conda/bin/conda install numpy pandas scikit-learn matplotlib seaborn pyyaml h5py keras -y && \
    /opt/conda/bin/conda upgrade dask && \
    pip install tensorflow imutils

RUN ["mkdir", "/opt/notebooks"]
#COPY conf/.jupyter /root/.jupyter
#COPY run_jupyter.sh /

# Jupyter and Tensorboard ports
EXPOSE 8888 6006

# Store notebooks in this mounted directory
VOLUME /opt/notebooks

CMD ["jupiter", "notebook", "--nodebook-dir=/opt/notebooks", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]