#!/bin/bash

# === Membuat direktori jika belum ada ===
sudo mkdir -p /usr/share/alsa/ucm2/Qualcomm/sm8250
sudo mkdir -p /usr/share/alsa/ucm2/conf.d/sm8250

# === Membuat HiFi.conf ===
sudo tee /usr/share/alsa/ucm2/Qualcomm/sm8250/HiFi.conf > /dev/null << 'EOF'
Syntax 3

SectionVerb {
    EnableSequence [
        # Enable MultiMedia1 routing -> TERTIARY_TDM_RX_0
        cset "name='TERT_TDM_RX_0 Audio Mixer MultiMedia1' 1"
    ]

    DisableSequence [
        cset "name='TERT_TDM_RX_0 Audio Mixer MultiMedia1' 0"
    ]

    Value {
        TQ "HiFi"
    }
}

# Add a section for AW88261 speakers
SectionDevice."Speaker" {
    Comment "Speaker playback"

    Value {
        PlaybackPriority 200
        PlaybackPCM "hw:\${CardId},0"  # PCM untuk TERTIARY_TDM_RX_0
    }
}
EOF

echo "✅ HiFi.conf berhasil dibuat."

# === Copy HiFi.conf menjadi HiFi_pipa.conf ===
sudo cp /usr/share/alsa/ucm2/Qualcomm/sm8250/HiFi.conf /usr/share/alsa/ucm2/Qualcomm/sm8250/HiFi_pipa.conf
echo "✅ HiFi.conf berhasil dicopy menjadi HiFi_pipa.conf."

# === Membuat atau mengganti isi Xiaomi Pad 6.conf ===
sudo tee "/usr/share/alsa/ucm2/conf.d/sm8250/Xiaomi Pad 6.conf" > /dev/null << 'EOF'
Syntax 3

SectionUseCase."HiFi" {
    File "/Qualcomm/sm8250/HiFi_pipa.conf"
    Comment "HiFi quality Music."
}

SectionUseCase."HDMI" {
    File "/Qualcomm/sm8250/HDMI.conf"
    Comment "HDMI output."
}
EOF

echo "✅ Xiaomi Pad 6.conf berhasil dibuat atau diperbarui."
