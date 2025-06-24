#!/bin/bash

# Pastikan direktori tujuan ada
sudo mkdir -p /usr/share/alsa/ucm2/Qualcomm/sm8250

# Tulis konfigurasi HiFi.conf dengan hak akses root
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

echo "✅ Audio configuration file created at /usr/share/alsa/ucm2/Qualcomm/sm8250/HiFi.conf"
