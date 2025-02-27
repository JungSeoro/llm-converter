from onnxruntime.quantization import quantize_dynamic, QuantType

model="Qwen2.5-0.5B-Instruct-onnx"
path = "/home/jsr/chat/public/models/"+model+"/onnx/" # onnx 모델 위치

#auto, fp32, fp16, q8, int8, uint8, q4, bnb4, q4f16
# quantize_dynamic(path+"model.onnx", path+"model_int16.onnx", weight_type=QuantType.QInt16)
# quantize_dynamic(path+"model.onnx", path+"model_uint16.onnx", weight_type=QuantType.QUInt16)
quantize_dynamic(path+"model.onnx", path+"model_int8.onnx", weight_type=QuantType.QInt8)
quantize_dynamic(path+"model.onnx", path+"model_uint8.onnx", weight_type=QuantType.QUInt8)
# quantize_dynamic(path+"model.onnx", path+"model_q4f16.onnx", weight_type=QuantType.QFLOAT8E4M3FN)
# quantize_dynamic(path+"model.onnx", path+"model_q4.onnx", weight_type=QuantType.QInt4)
# quantize_dynamic(path+"model.onnx", path+"model_qu4.onnx", weight_type=QuantType.QUInt4)