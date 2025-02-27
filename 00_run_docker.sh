#!/bin/bash

docker run --rm -it --gpus=all --env NVIDIA_DISABLE_REQUIRE=1 -v ~/onnx-converter:/vol -v ~/chat/public/models:/model jungseoro/onnx-converter-cuda
# docker run --rm -it --gpus all -v ~/onnx-converter:/vol -v ~/chat/public/models:/model jungseoro/onnx-converter-cuda