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

Luffy ingin menghubungi Franky yang berada di EniesLobby dengan denden mushi. Kalian diminta Luffy untuk membuat website utama dengan mengakses franky.E12.com dengan alias www.franky.E12.com pada folder kaizoku.  
  
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



