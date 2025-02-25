[한국어](README_KR.md) | [English](README.md)

# rknn_converter

**rknn_converter**는 모델을 RKNN 포맷으로 변환하는 과정을 간소화하도록 설계된 경량 도구입니다. 이 저장소에는 변환 과정을 자동화하는 스크립트가 포함되어 있어, 빠르고 간단하게 RKNN 변환을 수행할 수 있습니다.

## 주요 기능

- **간편한 변환**: 몇 가지 간단한 명령어만으로 모델을 RKNN 포맷으로 변환할 수 있습니다.
- **경량화**: 최소한의 의존성으로 빠른 실행이 가능합니다.
- **유연성**: 다양한 모델 형식을 지원하며, 필요에 따라 쉽게 확장할 수 있습니다.

## 설치 방법

터미널에서 다음 명령어를 실행하여 저장소를 클론합니다:

```bash
cd ~
git clone https://github.com/mechasolution/rknn_converter.git
```

## 사용 방법

저장소 디렉토리로 이동한 후, 변환 스크립트를 실행합니다:

```bash
cd ~/rknn_converter
sh convert.sh
```

## 참조된 저장소

- [ultralytics_yolov8](https://github.com/airockchip/ultralytics_yolov8.git)
- [rknn_model_zoo](https://github.com/airockchip/rknn_model_zoo.git)
