# ESA SNAP version 7 Docker image

## Build image

Clone repository and run:

```shell
git clone https://github.com/ValV/docker-esa-snap.git

cd docker-esa-snap

docker build --no-cache --rm -t valv/esa-snap .
```

> NOTE: in order to run `docker` without `sudo` you must be in `docker` group.

Instead of building the image, one can pull it from [Docker Hub](https://hub.docker.com/r/valv/esa-snap):

```shell
docker pull valv/esa-snap
```

## Run container

Show help for complete list of command-line options:

```shell
docker run --rm valv/esa-snap
```

> NOTE: use `--rm` key for container auto removal.

Process files with GPT (Graph Processing Tool):

```shell
mkdir ~/snap

cp S1A_EW_GRDM_1SDH_20200401T024402_20200401T024500_031928_03AFB1_056A.zip myGraph.xml ~/snap/

docker run --rm -v ~/snap:/root/snap valv/esa-snap snap/myGraph.xml
```
> NOTE: `/root` is the working directory by default.

Graph file _myGraph.xml_ has nodes for input and output files (note file paths):

```xml
  <node id="Read">
    <operator>Read</operator>
    <sources/>
    <parameters class="com.bc.ceres.binding.dom.XppDomElement">
      <file>snap/S1A_EW_GRDM_1SDH_20200401T024402_20200401T024500_031928_03AFB1_056A.zip</file>
      <formatName>SENTINEL-1</formatName>
    </parameters>
  </node>

...

  <node id="Write">
    <operator>Write</operator>
    <sources>
      <sourceProduct refid="Ellipsoid-Correction-GG"/>
    </sources>
    <parameters class="com.bc.ceres.binding.dom.XppDomElement">
      <file>snap/S1A_EW_GRDM_1SDH_20200401T024402_20200401T024500_031928_03AFB1_056A_NR_Orb_Cal_ML_Spk_EC.tif</file>
      <formatName>GeoTIFF</formatName>
    </parameters>
  </node>
```

> NOTE: instead of passing graph file, one can pass operations to GPT.

Run SNAP interactively with GUI:

```shell
docker run --rm -ti -v ~/snap:/root/snap
```

## About ESA SNAP

ESA Sentinel and SMOS Toolboxes preinstalled container for Earth Observation processing and analysis.

Contains: SNAP, S1TBX, S2TBX, S3TBX, SMOS Box, PROBA-V Toolbox (as provided by official SNAP installer).

Visit: https://step.esa.int/main.

Read documentation: [SNAP CommandLine Tutorial](http://step.esa.int/docs/tutorials/SNAP_CommandLine_Tutorial.pdf).

## Origins

This image is derived from [Alexander Schwankner's image](https://hub.docker.com/r/mundialis/esa-snap) fixed and optimized.
