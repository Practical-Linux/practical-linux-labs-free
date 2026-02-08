#!/usr/bin/env bash
set -euo pipefail

echo "[PL-000] Provisioning started..."

# Packages we want available in every lab
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get install -y --no-install-recommends \
  vim \
  less \
  tree \
  curl \
  ca-certificates

# Create a consistent student user (passwordless sudo for training)
if ! id -u student >/dev/null 2>&1; then
  useradd -m -s /bin/bash student
fi

usermod -aG sudo student
echo "student ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/90-student
chmod 0440 /etc/sudoers.d/90-student

# Install lab to /lab
rm -rf /lab
mkdir -p /lab

# Vagrant sync folder is /vagrant (points to PL-000 directory)
cp -r /vagrant/lab/* /lab/
chown -R root:root /lab
chmod -R a+rX /lab
chmod +x /lab/check.sh

# Make achievements folder ready
mkdir -p /home/student/.achievements
chown -R student:student /home/student/.achievements

# Optional: show a simple login message (kept minimal)
cat >/etc/motd <<'EOF'
Practical Linux — Lab PL-000
Tip: cd /lab
EOF

echo "[PL-000] Provisioning complete."

