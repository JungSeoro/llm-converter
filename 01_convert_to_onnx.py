from transformers import AutoModelForCausalLM, AutoTokenizer
from optimum.onnxruntime import ORTModelForCausalLM
from optimum.exporters.onnx import export_model
import torch

MODEL_NAME = "/model/bert-base-uncased"
ONNX_PATH = "./output"

# 모델 & 토크나이저 로드
model = AutoModelForCausalLM.from_pretrained(MODEL_NAME)
tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)

# ONNX 변환
export_model(model, tokenizer, ONNX_PATH, task="text-generation")

print("✅ ONNX 모델 변환 완료!")
