#!/bin/bash

MODEL="best.pt"

# ---------- pt → onnx ----------
echo "🔄 [INFO] rknn_converter 디렉토리로 이동 중..."
cd "$HOME/rknn_converter" || { echo "❌ [ERROR] rknn_converter 디렉토리 없음"; exit 1; }
echo ""

if [ -d "ultralytics_yolov8" ]; then
    echo "🗑️ [INFO] 기존 ultralytics_yolov8 폴더 삭제 중..."
    rm -rf "ultralytics_yolov8"
    echo ""
fi

echo "🚀 [INFO] ultralytics_yolov8 클론 중..."
git clone "https://github.com/airockchip/ultralytics_yolov8.git"  --depth=1 \
    || { echo "❌ [ERROR] ultralytics_yolov8 클론 실패"; exit 1; }
echo ""

echo "🔗 [INFO] ultralytics_yolov8 의존성 설치 중..."
pip3 install ~/rknn_converter/ultralytics_yolov8/. \
    || { echo "❌ [ERROR] ultralytics_yolov8 의존성 설치 실패"; exit 1; }
echo ""

echo "📂 [INFO] MODEL ($MODEL) 파일 복사 중..."
cp -f "$MODEL" "$HOME/rknn_converter/ultralytics_yolov8/$MODEL" \
    || { echo "❌ [ERROR] MODEL ($MODEL) 파일 복사 실패"; exit 1; }
echo ""

echo "🔧 [INFO] default.yaml 치환 중..."
sed -i "s/yolov8n.pt/$MODEL/g" \
    "$HOME/rknn_converter/ultralytics_yolov8/ultralytics/cfg/default.yaml" \
    || { echo "❌ [ERROR] 치환 실패"; exit 1; }
export PYTHONPATH=~/rknn_converter/ultralytics_yolov8/
echo ""

echo "🏃 [INFO] exporter.py 실행 중 (pt → onnx 변환)..."
python3 "$HOME/rknn_converter/ultralytics_yolov8/ultralytics/engine/exporter.py" \
    || { echo "❌ [ERROR] exporter.py (pt → onnx 변환) 실행 실패"; exit 1; }
echo ""

# ---------- onnx → rknn ----------
echo "🏃 [INFO] convert.py 실행 (onnx → rknn 변환)..."
MODEL="${MODEL%.pt}.onnx"
OUT="${MODEL%.onnx}.rknn"
python3 "$HOME/rknn_converter/convert.py" \
    "$HOME/rknn_converter/$MODEL" \
    rk3588 fp \
    "$HOME/rknn_converter/$OUT" \
    || { echo "❌ [ERROR] convert.py (onnx → rknn 변환) 실행 실패"; exit 1; }
echo ""

echo -e "✅ [SUCCESS] 변환 완료!\n최종 RKNN 파일: $HOME/rknn_converter/$OUT"
exit 0