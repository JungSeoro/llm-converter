#!/bin/bash

optimum-cli onnxruntime quantize --avx512 --onnx_model $1 -o $2