#!/bin/bash

echo "=== Mematikan dan memblokir PipeWire ==="
systemctl --user mask pipewire-pulse.service
systemctl --user stop pipewire-pulse.service
systemctl --user mask pipewire.socket
systemctl --user stop pipewire.socket
systemctl --user stop pipewire.service pipewire-pulse.service

echo "=== Mengaktifkan dan memulai PulseAudio ==="
systemctl --user unmask pulseaudio.service pulseaudio.socket
systemctl --user enable pulseaudio.service pulseaudio.socket
systemctl --user start pulseaudio.service pulseaudio.socket

echo "=== Memperbarui paket dan menginstal aplikasi penting ==="
sudo apt update && sudo apt upgrade -y
sudo apt install -y gdebi gnome-tweaks neofetch ubuntu-restricted-extras gstreamer1.0-pulseaudio

echo "=== Selesai! PulseAudio sekarang aktif. ==="
