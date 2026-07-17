function avgtime --description "Average runtime of a command over N iterations"
    if test (count $argv) -lt 2
        echo "Usage: avgtime ITERATIONS COMMAND [ARGS...]"
        return 1
    end

    set -l iterations $argv[1]
    set -l cmd $argv[2..-1]

    # Start timestamp (nanoseconds since epoch)
    set -l start (date +%s%N)

    for i in (seq $iterations)
        $cmd >/dev/null
    end

    set -l finish (date +%s%N)

    set -l total_ns (math "$finish - $start")
    set -l avg_ns (math "$total_ns / $iterations")

    printf "Iterations: %d\n" $iterations
    printf "Total: %.6f s\n" (math "$total_ns / 1e9")
    printf "Average: %.6f ms\n" (math "$avg_ns / 1e6")
end
