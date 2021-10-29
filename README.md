# Jarkom-Modul-2-E12-2021

<hr/>  

#### Anggota Kelompok :
 * Adjie
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
![image](https://user-images.githubusercontent.com/75328763/139467067-3a72f81f-8125-4e46-8ce2-a4cad1c645a7.png)  

## Soal 2  


