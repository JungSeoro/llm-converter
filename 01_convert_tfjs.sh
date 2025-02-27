#!/bin/bash

set -e

MODEL_NAME_OR_PATH=${1:-gpt2}
OUTPUT_DIR=${2:-"/app/models/$MODEL_NAME_OR_PATH/tfjs_model"}

INPUT_DIR="/app/models/$MODEL_NAME_OR_PATH"

if [ -d "$MODEL_NAME_OR_PATH" ]; then
    echo "Using local model directory: $MODEL_NAME_OR_PATH"
    INPUT_DIR="$MODEL_NAME_OR_PATH"
else
    echo "Downloading model from Hugging Face: $MODEL_NAME_OR_PATH..."
    mkdir -p "$INPUT_DIR"
    python3 -c "
from transformers import TFAutoModelForCausalLM, AutoTokenizer

print('Loading model:', '$MODEL_NAME_OR_PATH')
model = TFAutoModelForCausalLM.from_pretrained('$MODEL_NAME_OR_PATH', from_pt=True)
tokenizer = AutoTokenizer.from_pretrained('$MODEL_NAME_OR_PATH')

print('Saving TensorFlow model to:', '$INPUT_DIR')
model.save_pretrained('$INPUT_DIR', saved_model=True)
tokenizer.save_pretrained('$INPUT_DIR')
"
fi

echo "Converting TensorFlow model to TensorFlow.js format..."
tensorflowjs_converter \
    --input_format=tf_saved_model \
    --saved_model_tags=serve \
    "$INPUT_DIR/saved_model/1" "$OUTPUT_DIR"

echo "Conversion complete. TensorFlow.js model saved to: $OUTPUT_DIR"
