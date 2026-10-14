#!/bin/bash
# GitHub Actions에서 CelesTrak 궤도 데이터를 받아 tle/*.txt 와 satcat.csv 를 갱신한다.
# (브라우저가 아닌 서버에서 받으므로 CelesTrak 요청 제한에 걸리지 않는다.)
set -e
mkdir -p tle
UA="SAT-Tracking-Studio/1.0 (+https://github.com/WOOJEONGRYEOL/sat-tracking-studio)"

for g in stations visual gnss weather geo starlink active; do
  if curl -sfL -A "$UA" "https://celestrak.org/NORAD/elements/gp.php?GROUP=$g&FORMAT=tle" -o "tle/$g.tmp" \
     && grep -q "^1 " "tle/$g.tmp"; then
    mv "tle/$g.tmp" "tle/$g.txt"
    echo "updated tle/$g.txt"
  else
    echo "skip $g (fetch failed)"; rm -f "tle/$g.tmp"
  fi
  sleep 2
done

# SATCAT(국가·발사일 등 메타데이터)은 느리게 변하므로 6일 이상 지났을 때만 갱신 (저장소 비대화 방지)
need=1
last=$(git log -1 --format=%ct -- satcat.csv 2>/dev/null || echo 0)
now=$(date +%s)
[ -f satcat.csv ] && [ $((now - last)) -lt 518400 ] && need=0
if [ "$need" = 1 ]; then
  if curl -sfL -A "$UA" "https://celestrak.org/pub/satcat.csv" -o satcat.tmp \
     && head -1 satcat.tmp | grep -q OBJECT_NAME; then
    mv satcat.tmp satcat.csv
    echo "updated satcat.csv"
  else
    echo "skip satcat (fetch failed)"; rm -f satcat.tmp
  fi
fi
