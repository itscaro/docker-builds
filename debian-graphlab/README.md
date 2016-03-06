# Containerised scientific Python workstation

This container is based on
* [ipython/scipystack](https://hub.docker.com/r/ipython/scipystack/)) 
* [rjw57/jupyter](https://hub.docker.com/r/rjw57/jupyter/))

The container exposes a single port which the Jupyter notebook server runs on.
Launch the container with an incantation similar to the following:

```console
$ docker run -i -p 8888:8888/tcp -e GRAPHLAB_VERSION "" -e GRAPHLAB_EMAIL "" -e GRAPHLAB_LICENSE "" itscaro/graphlab
```

By default the Jupyter notebook runs as a user which is given ``sudo`` access
inside the container. **NOTE THAT HAVING ROOT IN THE CONTAINER SHOULD BE VIEWED
AS HAVING ROOT ON THE HOST.** The user logon name and id can be configured by
setting the ``USER`` and ``USER_UID`` environment variables. For example, to
launch the container for the current user:

```console
$ docker run -i -p 8888:8888/tcp -e USER -e USER_UID=$(id -u) -e GRAPHLAB_VERSION "" -e GRAPHLAB_EMAIL "" -e GRAPHLAB_LICENSE "" itscaro/graphlab
```

## Virtual machine using Vagrant

If you have Vagrant installed, the provided Vagrant file can be used to
provision a virtual machine running the container.

