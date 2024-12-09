
function update-os {
  echo -e ">>> Upgrading OS..."
  pkg update
  pkg upgrade -y

  echo -e ">>> Cleaning packages..."
  pkg autoclean
  pkg clean

  echo -e ">>> Done."
}
