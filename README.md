<span style="text-align: center;">

# No Fuss Computing - Kubernetes Manifest Tools

<br>

![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2Fnofusscomputing%2Fkubernetes-manifest-tools%2Frefs%2Fheads%2Fdevelopment%2F.meta%2Fproject_status.json)

----

<br>

![GitHub forks](https://img.shields.io/github/forks/NofussComputing/kubernetes-manifest-tools?logo=github&style=plastic&color=000000&labell=Forks) ![GitHub stars](https://img.shields.io/github/stars/NofussComputing/kubernetes-manifest-tools?color=000000&logo=github&style=plastic) ![Github Watchers](https://img.shields.io/github/watchers/NofussComputing/kubernetes-manifest-tools?color=000000&label=Watchers&logo=github&style=plastic)


---

</span>

<br>

This repository is for a docker container that contains various tools for working with and manipulating Kubernetes Manifests.


## Using this Container

This container can be used from the console (requires docker be installed), as a Github Actions or as part of a Gitlab CI/CD Pipeline.

 ``` bash
 
docker run -ti \
  -e "KUBECTL_SLICE_INPUT_FILE=k8s-manifest-file.yaml" \
  -e "KUBECTL_SLICE_OUTPUT_DIR=/split" \
  -v ${PWD}:/workdir \
  --rm \
  nofusscomputing/kubernetes-manifest-tools:latest

```

### Variables

The container has variables available for use that are only required if not using this container as part of a github action.

| ENV variable | Github Action Inputs | Description |
|:---:|:---:|:---|
| `KUBECTL_SLICE_INPUT_FILE` | _input-file_ | Kubernetes Manifest to process. must be relative path to file from root of repository. If a URL is supplied, the manifest will be downloaded. ||
| `KUBECTL_SLICE_OUTPUT_DIR` | _output-dir_ | The directory where the manifests will be saved to. |
| `NFC_FORMAT_YAML` | _format-yaml_ | If set, the YAML files will have the yaml header `---` added and have the indentation set to `2`. |
| `KUBECTL_SLICE_TEMPLATE` | _filename-format_ | Sets the format of the filename. defaults to `<Kubernetes Kind name in CamelCase>-<manifest name in lowercase>.yaml` |



## Contributing

As this repository is intended to be a single location for deploying all of your kubernetes services. We encourage collaborataion and welcome All contributions.

For further details on contributing please refer to the [contribution guide](CONTRIBUTING.md).


## Other

This repo is release under this [licence](LICENCE)
