# build with:
# docker build . -t godot-builder:latest
FROM fedora:41

#COPY ./godot /home/godot/godot

# configure the godot user
RUN useradd -m godot
RUN usermod -aG wheel godot
RUN echo "godot ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers

# switch to godot user
USER godot

# update environment
RUN sudo dnf update -y
RUN sudo dnf install -y \
  scons \
  pkgconfig \
  gcc-c++ \
  libstdc++-static \
  wayland-devel \
# optional
  dotnet-sdk-8.0 \
  libasan \
  python3-zstandard
#  pip \
#  git
  
RUN sudo chown -R godot /home/godot

#WORKDIR /home/godot
#RUN sudo git clone https://github.com/godotengine/godot.git
WORKDIR /home/godot/godot

#RUN pip install --user zstandard

CMD ["bash"]