# Jarkom-Modul-2-E12-2021

<hr/>  

#### Anggota Kelompok :
 * Rahadian Adjie Mahesa &nbsp;(05111940000221)
 * Luthfi
 * Afifan Syafaqi Yahya &nbsp; (05111940000234)  

#### Prefix IP 
Address untuk Prefix IP Kelompok kami adalah `10.35`

<hr/>  

## Soal 1

EniesLobby akan dijadikan sebagai DNS Master, Water7 akan dijadikan DNS Slave, dan Skypie akan digunakan sebagai Web Server. Terdapat 2 Client yaitu Loguetown, dan Alabasta. Semua node terhubung pada router Foosha, sehingga dapat mengakses internet.  
![image](https://user-images.githubusercontent.com/75328763/139465113-72289220-fe54-416c-8ef3-5c8f3e93c56a.png)  
**Penjelasan :**  
1. Pertama-tama, men-drop host, switch, router, dan NAT sesuai dengan gambar topology yang ada diatas  
2. Kedua, menggunkanan fitur *Add Link* yang sudah tersedia dan menghubungkan node sesuai dengan topology yang akan digambar.
3. Ketiga, melakukan ste-up dengan cara mengkonfigurasi settingan dari tiap netwotk node. Konfigurasi Setting yang sudah ada akan digantikan dengan settingan sebagai berikut.  
a. Foosha
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 10.35.1.1
    netmask 255.255.255.0

auto eth2
iface eth2 inet static
    address 10.35.2.1
    netmask 255.255.255.0
```  
b. LogueTown
```
auto eth0
iface eth0 inet static
    address 10.35.1.2
    netmask 255.255.255.0
    gateway 10.35.1.1
```  
c. Alabasta
```
auto eth0
iface eth0 inet static
    address 10.35.1.3
    netmask 255.255.255.0
    gateway 10.35.1.1
```
d. EniesLobby
```
auto eth0
iface eth0 inet static
    address 10.35.2.2
    netmask 255.255.255.0
    gateway 10.35.2.1
```  
e. Water7
```
auto eth0
iface eth0 inet static
    address 10.35.2.3
    netmask 255.255.255.0
    gateway 10.35.2.1
```  
f. Skypie
```
auto eth0
iface eth0 inet static
    address 10.35.2.4
    netmask 255.255.255.0
    gateway 10.35.2.1
```  
lalu Kemudian, restart seluruh node.  
  
4. Keempat, masukan command `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.35.0.0/16` pada console node Foosha.  

5. Masukan command `echo nameserver 192.168.122.1 > /etc/resolv.conf` ke pada semua console client node agar bisa mengakses internet.  
  
6. Check berhasil dengan melakukan test ping google.com pada client.  
![Loguetown-ping google](https://user-images.githubusercontent.com/75328763/139468464-814d4d62-d338-4079-8746-e9588b970c22.png)

## Soal 2  

Luffy ingin menghubungi Franky yang berada di EniesLobby dengan denden mushi. Kalian diminta Luffy untuk membuat website utama dengan mengakses *franky.E12.com* dengan alias *www.franky.E12.com* pada folder kaizoku.  
  
**Pembahasan :**  
1. Membuka console pada node EniesLobby, setelah mengakses internet dengan melakukan command sebagai berikut.
```
echo nameserver 192.168.122.1 > /etc/resolv.conf
```  
Lalu install dan update package list dan bind9 menggunakan comman sebagai berikut.
```
apt-get update
```
```
apt-get indtall bind9 -y
```  
  
2. Setelah berhasi install, lakukan berintah berikut:
```
 nano /etc/bind/named.conf.local
```  
  
3. Lalu mengisi konfigurasi yang berada pada file **franky.E12.com** dengan sintaks sebagai berikut.
```
zone "franky.e14.com" {
    type master;
    file "/etc/bind/kaizoku/franky.e14.com";
};
```  
![(no2)EniesLobby-named-conf-local](https://user-images.githubusercontent.com/75328763/139470881-a9a1799b-480b-41de-bd88-0a2205529120.png)
 
  
4. Kemudian membiuat folder **kaizoku** pada */etc/bind* menggunakan sintaks:
```
mkdir /etc/bind/kaizoku
```  
  
5. Mengcopy file *db.local* pada path */etc/bind* ke dalam folder **kaizoku** dan ubah nama file tersebut menjadi **franky.E12.com** dengan menggunakan sintaks:  
```
cp /etc/bind/db.local /etc/bind/kaizoku/franky.E12.com
```  
  
6. Kemudain buka file *frnaky.E12.com* dan edit seperti gambar berkut:  
```
nano /etc/bind/kaizoku/franky.E12.com
```  
![(no2)EniesLobby-franky-E12-com](https://user-images.githubusercontent.com/75328763/139471382-244a1d20-2b75-4809-8d7c-87762abcb1d7.png)  
  
7. Lalu, restart bind9 dengan command:
```
service bind9 restart
```  
  
8. Setelah itu, pada file */etc/bind/resolv.conf* pada node client(Loguetown) diganti menjadi IP dari EniesLobby dengan cara command:  
```
echo nameserver 10.35.2.2 > /etc/resolv.conf
```  
  
9. Untuk pengecheckan, lakukan `ping franky.E12.com` dan `ping www.franky.E12.com` pada client node.   
![(no2)Loguetown-ping-test](https://user-images.githubusercontent.com/75328763/139472306-6ff3de35-1a4d-4a49-a871-91e4872cb3c8.png)  
  
## Soal 3  
Setelah itu buat subdomain *super.franky.E12.com* dengan alias *www.super.franky.E12.com* yang diatur DNS nya di EniesLobby dan mengarah ke Skypie.  
  
**Pembahasan :**  
1. Edit file **/etc/bind/kaizoku/franky.e14.com** pada console node EniesLobby lalu tambahkan subdomain untuk *franky.E12.com* yang mengarah ke IP Skypie (10.35.2.2).  
![(no3)EniesLobby-franky-E12-com](https://user-images.githubusercontent.com/75328763/139473260-0a5209d7-e70f-4bdd-8c48-7935607fbda6.png)  
Setelah sudah di-save, lakuan restart bind9 menggunakan command:  
```
service bind9 restart
```  
  
2. Untuk penge-checkan berhasil tidaknya, lakukan `ping super.franky.e14.com` dan `ping www.super.franky.e14.com` pada node client.  
![(no3)Loguetown-ping-test](https://user-images.githubusercontent.com/75328763/139473812-66667445-c7ec-4cad-8c28-d5e1d131e682.png)  
  
## Soal 4  
Buat juga reverse domain untuk domain utama.  
**Pembahasan :**
1. Membuka file */etc/bind/ named.conf.local* pada EniesLobby menggunakan `nano /etc/bind/named.conf.local`, lalu tambahkan pada fie tersebut konfigurasi reverse dari 3 byte awal dari IP yang ingin dilakukan reverse DNS.  
```
zone "2.35.10.in-addr.arpa" {
   type master;
   file "/etc/bind/kaizoku/2.35.10.in-addr.arpa";
};
```  
![(no4)EniesLobby-named-conf-local](https://user-images.githubusercontent.com/75328763/139475311-42de4f13-17a4-406b-95a9-6a994e0591f1.png)  
  
2. Copykan file *db.local* pada path */etc/bind* ke dalam folder **kaizoku** yang baru saja dibuat dan ubah namanya menjadi **2.35.10.in-addr.arpa** menggunakan command:  
```
cp /etc/bind/db.local /etc/bind/kaizoku/2.35.10.in-addr.arpa
```  
  
3. Edit file **2.35.10.in-addr.arpa** menjadi seperti berikut:  
![(no4)EniesLobby-2-35-10-in-addr-arp](https://user-images.githubusercontent.com/75328763/139475939-12db42f5-8bf2-4133-af05-da1ce9b18de8.png)  
Kemudian lakukan restar bidn9 nya menggunakan command `service restart bind9 restart'.  
  
4. Untuk mengecheck apakah konfigurasinya sudah benar, lakukan perintah-perintah berikut pada node client:  
&nbsp;* Ubah nameserver pada file */etc/resolcv.conf* ke nameserver Foosha(192.168.122.1) dengan command `echo nameserver 192.168.122.1 > /etc/resolv.conf` agar dapat mengakses internet.  
&nbsp;* Install package *dnsutils* dengan melakukan command `apt-get install dnsutils`.  
&nbsp;* Kembalikan nameserver pada file */etc/resolv.conf* ke nameserver EniesLobby menggunakan command `echo nameserver 10.35.2.2 > /etc/resolv.conf`.  
&nbsp;* Check dilakukan dengan menggunakan perintah berikut untuk memastikan konfigurasi sudah benar. IP yang digunakan adalah IP EniesLobby.  
```
host -t PTR 10.35.2.2
```  
Berikut adalah hasil Konfigurasinya:  
![(no4)Loguetown-ping-test](https://user-images.githubusercontent.com/75328763/139477851-d675b5f2-ee5c-4ee7-b83a-6380b6f3e8cc.png)  
  
## Soal 5  
Supaya tetap bisa menghubungi Franky jika server EniesLobby rusak, maka buat Water7 sebagai DNS Slave untuk domain utama.  
  
**Pembahasan :**
1. Edit isi file */etc/bind/named.conf.local* pada EniesLobby sebagai berikut:  
```
zone "franky.E12.com" {
   type master;
   notify yes;
   also-notify { 10.35.2.3; }; // Masukan IP Water7 tanpa tanda petik
   allow-transfer { 10.35.2.3; }; // Masukan IP Water7 tanpa tanda petik
   file "/etc/bind/kaizoku/franky.E12.com";
};
```  
![(no5)EniesLobby-named-conf-local](https://user-images.githubusercontent.com/75328763/139478579-53dba3c0-50be-4120-af38-c69143779c7a.png)  
Lalu lakukan restart bind9 denagn command `service bind9 restart`.  
  
2. Membuka console pada node Water7 kemudian update install bind9.
```
apt-get update
apt-get install bind9 -y
```  
  
3. Kemudian buka file */etc/bind/namad.conf.local* pada Water7 dan edit konfigurasinya sebagaimana berikut:  
```
zone "franky.E12.com" {
   type slave;
   masters { 10.35.2.2; }; // Masukan IP EniesLobby tanpa tanda petik
   file "/var/lib/bind/franky.E12.com";
};
```  
![(no5)Water7-named-conf-local](https://user-images.githubusercontent.com/75328763/139480976-cea0849e-424d-42d8-bad4-a56943fd89d6.png)  
Lalu lakukan restart bind9 denagn command `service bind9 restart`.  
  
4. Untuk melakukan testing, dapat dilakukan dengan:  
&nbsp;* Matikan service pada EniesLobby dengan menggunakan command `service bind9 stop`.  
&nbsp;* Buka console pada node client kemudian tambahkan nameserver Water7 pada file */etc/resolv.conf*.
```
nameserver 10.36.2.2
nameserver 10.36.2.3
```  
&nbsp;* Lalu lakukan `ping franky.E12.com` pada node client.  
  
## Soal 6  




