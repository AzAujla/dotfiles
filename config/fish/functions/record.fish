function record --description "Record screen with gpu-screen-recorder"
    if test (count $argv) -eq 0
        echo "Usage: record <filename>"
        return 1
    end

    set output ~/Videos/Captures/$argv[1].mp4

    gpu-screen-recorder \
        -w eDP-1 \
        -f 144 \
        -q very_high \
        -k h264 \
        -c mp4 \
        -a default_output \
        -o $output

    echo "Saved to $output"
end
