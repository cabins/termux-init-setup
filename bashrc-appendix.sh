
function update-os {
    echo -e ">>> Upgrading OS..."
    pkg update
    pkg upgrade -y

    echo -e ">>> Cleaning packages..."
    pkg autoclean
    pkg clean

    echo -e ">>> Done."
}

function update-pip {
    PIP_OUTDATED_PACKAGES=$(pip list --outdated | tail -n +3)
    if [ "" == "$PIP_OUTDATED_PACKAGES" ]; then
        echo "Python packages are already latest."
        return
    fi

    echo $PIP_OUTDATED_PACKAGES | awk '{print $1}' | xargs pip install -U
    echo "Pip upgrade done."
}
