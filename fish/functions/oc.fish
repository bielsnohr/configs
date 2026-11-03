function oc --description 'Open inference tunnel if needed, then start OpenCode in sbx'
    if not nc -z localhost 8001 2>/dev/null
        echo "Opening inference tunnel…"
        if not ssh -fN inference-tunnel
            echo "Tunnel failed" >&2
            return 1
        end
    end
    sbx run opencode $argv # swap in whatever sbx command you normally use
end
