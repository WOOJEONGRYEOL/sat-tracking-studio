# 🛰️ SAT Tracking Studio

대한민국 상공을 지나는 인공위성·우주정거장을 실시간으로 추적하고, **달 앞을 지나가는 ISS·톈궁(lunar transit)을 촬영할 수 있는 날짜·시각·위치**를 계산하는 단일 파일 웹앱입니다.

**라이브:** https://woojeongryeol.github.io/sat-tracking-studio/

## 기능
- **천구도 모드**: 하늘을 올려다보는 극좌표 차트에 위성 실시간 위치 + 별자리·달(위상 포함) 배경
- **3D 지구 모드**: 한반도가 정면에 오는 지구본 위에 위성 궤도·고도를 표시 (국경선 오버레이, 고도 과장 배율)
- **카테고리**: 밝은 위성 / 🇰🇷 한국 위성 / 항법(GNSS) / 기상 / 정지궤도 / 스타링크 / 전체 활동 위성
- **국가별 검색** 및 위성 상세 정보(국가·종류·발사일·궤도)
- **ISS·톈궁 통과 예보** (24시간) + **맨눈 관측 가능 여부**
- **🌙 달면 통과(트랜싯) 촬영 예보**: 최근접 순간(0.05초 정밀), 달 위상·고도·방위, 위성 겉보기 크기·통과 지속시간, 중심선까지 이동 방향·거리, **지도 표시**
- 한국어 / English 전환

## 데이터
- 궤도 데이터(TLE): [CelesTrak](https://celestrak.org) — `tle/*.txt`
- 위성 카탈로그(국가·발사일): CelesTrak SATCAT — `satcat.csv`
- 궤도 전파: [satellite.js](https://github.com/shashwatak/satellite-js) (SGP4), 브라우저에서 계산
- 3D: [Three.js](https://threejs.org), 지도: [Leaflet](https://leafletjs.com) + OpenStreetMap, 별: [d3-celestial](https://github.com/ofrohn/d3-celestial)

`tle/*.txt` 와 `satcat.csv` 는 GitHub Actions(`.github/workflows/refresh-tle.yml`)가 **6시간마다 자동 갱신**합니다.

## 로컬 실행
```bash
python3 -m http.server 8765
# http://localhost:8765
```

정밀 촬영 전에는 최신 궤도 데이터로 다시 계산하세요 (ISS는 궤도 재상승으로 예측이 빨리 낡습니다).
