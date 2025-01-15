import os

from rknn.api import RKNN


MODEL_PATH = "./best.onnx"
SUBSET_PATH = "./subsets.txt"
IMG_SIZE = 640

PLATFORM = "RK3588"
RKNN_MODEL_PATH = "./yolov8_mechaship.rknn"
DEFAULT_QUANT = False

# subset 폴더 내의 파일 리스트 가져오기
file_list = os.listdir("./subset")

# 파일 리스트를 텍스트 파일로 저장
with open(SUBSET_PATH, "w") as f:
    for file_name in file_list:
        f.write("./subset/" + file_name + "\n")

# RKNN 불러오기
rknn = RKNN(verbose=False)

# 전처리 구성
print("--> Config model")
rknn.config(
    mean_values=[[0, 0, 0]], std_values=[[255, 255, 255]], target_platform=PLATFORM
)
print("done")

# ONNX 모델 불러오기
print("--> Loading model")
ret = rknn.load_onnx(model=MODEL_PATH)
if ret != 0:
    print("Load model failed!")
    exit(ret)
print("done")

# 모델 빌드하기
print("--> Building model")
ret = rknn.build(do_quantization=DEFAULT_QUANT, dataset=SUBSET_PATH)
if ret != 0:
    print("Build model failed!")
    exit(ret)
print("done")

# RKNN 모델 내보내기
print("--> Export rknn model")
ret = rknn.export_rknn(RKNN_MODEL_PATH)
if ret != 0:
    print("Export rknn model failed!")
    exit(ret)
print("done")

# 반환하기
rknn.release()
