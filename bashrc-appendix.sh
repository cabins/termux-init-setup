
function update-os {
    echo -e "\n⁂ Upgrading OS..."
    pkg update
    pkg upgrade -y

    echo -e "\n⁂ Cleaning packages..."
    pkg autoclean
    pkg clean

    echo -e "\n⁂ Done."
}

function update-pip {
    PIP_OUTDATED_PACKAGES=$(pip list --outdated | tail -n +3)
    if [ "" == "$PIP_OUTDATED_PACKAGES" ]; then
        echo -e "\n⁂ Python packages are already latest."
        return
    fi

    echo $PIP_OUTDATED_PACKAGES | awk '{print $1}' | xargs pip install -U
    echo -e "\n⁂ Pip upgrade done."
}
