#!/bin/bash

ENVOY_PID=$(pgrep envoy)
DURATION=60
RPS=1000
PROTOCOL=https
ENVOY_URL=https://127.0.0.1:10000/

PLOT_OUT="${HOME}/Git/io_uring_performance_setup/output/${PROTOCOL}_${RPS}rps.png"
PLOTTEXT_OUT="${HOME}/Git/io_uring_performance_setup/output/${PROTOCOL}_${RPS}rps_plot.txt"
CPU_OUT="${HOME}/Git/io_uring_performance_setup/output/${PROTOCOL}_cpu_${RPS}rps.txt"
MEM_OUT="${HOME}/Git/io_uring_performance_setup/output/${PROTOCOL}_mem_${RPS}rps.txt"
BENCH_OUT="${HOME}/Git/io_uring_performance_setup/output/${PROTOCOL}_${RPS}rps.json"
FORTIO_OUT="${HOME}/Git/io_uring_performance_setup/output/fortio/${PROTOCOL}_${RPS}rps.json"
HUMAN_OUT="${HOME}/Git/io_uring_performance_setup/output/human_benchmark/${PROTOCOL}_${RPS}rps.txt"

if [[ $PROTOCOL=https ]]; then
    PROTOCOL=http1
fi

taskset -c 2 bazel-bin/nighthawk_client --rps $RPS --connections 4 --concurrency auto --prefetch-connections --duration $DURATION -p $PROTOCOL --output-format json --latency-response-header-name lat_resp -v info $ENVOY_URL > $BENCH_OUT &
taskset -c 3 pidstat -p $ENVOY_PID 1 $(($DURATION + 1)) > $CPU_OUT &
taskset -c 3 pidstat -p $ENVOY_PID -r 1 $(($DURATION + 1))> $MEM_OUT &
taskset -c 3 psrecord $ENVOY_PID --log $PLOTTEXT_OUT --interval 1 --duration $(($DURATION + 1)) --plot $PLOT_OUT &

wait
cat $BENCH_OUT | bazel-bin/nighthawk_output_transform --output-format human > $HUMAN_OUT &
cat $BENCH_OUT | bazel-bin/nighthawk_output_transform --output-format fortio > $FORTIO_OUT &

wait
exit 0