function log-echo {
    echo -e "\n🍒🍒🍒 $1\n"
}

function update-os {
    log-echo "Upgrading OS..."
    pkg update
    pkg upgrade -y

    log-echo "Cleaning packages..."
    pkg autoclean
    pkg clean

    log-echo "Done."
}

function update-pip {
    PIP_OUTDATED_PACKAGES=$(pip list --outdated | tail -n +3)
    if [ "" == "$PIP_OUTDATED_PACKAGES" ]; then
        log-echo "Python packages are already latest."
        return
    fi

    echo $PIP_OUTDATED_PACKAGES | awk '{print $1}' | xargs pip install -U
    log-echo "Pip upgrade done."
}
