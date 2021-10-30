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
Setelah itu terdapat subdomain *mecha.franky.E12.com* dengan alias *www.mecha.franky.E12.com* yang didelegasikan dari EniesLobby ke Water7 dengan IP menuju ke Skypie dalam folder **sunnygo**  
  
**Pembahasan :**  
1. Pada EniesLobby, edit file */etc/bind/kaizoku/franky.E12.com* menggunakan command `nano /etc/bind/kaizoku/franky.E12.com` dan ubah konfigurasi sebagai berikut:  
![(no6)EniesLobby-franky-E12-com](https://user-images.githubusercontent.com/75328763/139481920-158509ad-d124-45ef-990f-bbb45a33c792.png)  
  
2. Berikutnya edit file */etc/bind/named.conf.options* pada EniesLobby menggunakan command `nano /etc/bind/named.conf.options` setelah itu edit isinya sebagaimana berikut:  
![(no6)EniesLobby-named-conf-options](https://user-images.githubusercontent.com/75328763/139482620-1c696f63-0393-4c80-909f-d7fdb36cb303.png)  
  
3. Kemudian edit isi dari file */etc/bind/named.conf.local* menjadi seperti gambar beriikut:  
![(no6)EniesLobby-named-conf-local](https://user-images.githubusercontent.com/75328763/139483119-dc13533a-e5c3-4944-beb5-b9664a9be224.png)  
Lalu restart bind9 menggunakan command `service bind9 restart`.  
  
4. Pada console node Water7, edit file */etc/bind/named.conf.options* sebagaimana gambar berikut:  
![(no6)Water7-named-conf-options](https://user-images.githubusercontent.com/75328763/139483688-9aca1eeb-5ecc-40b4-b20f-2e5ddc8e6009.png)  
  
5. Lalu edit juga file */etc/bind/named.conf.local* pada console Water7 menjadi sebagaimana gambar berikut:  
![(no6)Water7-named-conf-local](https://user-images.githubusercontent.com/75328763/139484496-c85a55dc-ab01-4e85-b62a-f506a6302f4b.png)  
  
6. Kemudian buat direktori baru dengan nama **sunygo** pada Water7.
```
mkdir /etc/bind/sunnygo
```  
  
7. Copy db.local ke direktori **sunnygo** dan edit namanya menjadi *mecha.franky.E12.com* menggunakan command berikut:  
```
cp /etc/bind/db.local /etc/bind/sunnygo/mecha.franky.E12.com
```  
    
8. Lalu edit file *mecha.franky.E12.com* tersebut menggunakan command `nano /etc/bind/sunnygo/mecha.franky.E12.com` menjadi seperti gambar berikut:  
![(no6)Water7-mecha-franky-E12-com](https://user-images.githubusercontent.com/75328763/139485494-c3d9a6ca-d4d8-4235-a8c1-1ccffcb3407a.png)  
Lalu restart bind9 menggunakan command `service bind9 restart`.  
  
9. Untuk testing, dengan menggunakan `ping mecha.franky.E12.com` dan `ping www.mecha.franky.E12.com` pada node client.   
![(no6)Loguetown-ping-test](https://user-images.githubusercontent.com/75328763/139486488-152dc4c0-00e1-41f2-b29b-956281d63c84.png)  
  
## Soal 7
Untuk memperlancar komunikasi Luffy dan rekannya, dibuatkan subdomain melalui Water7 dengan nama *general.mecha.franky.E12.com* dengan alias *www.general.mecha.franky.E12.com* yang mengarah ke Skypie  
  
**Pembahasan :**
1. Edit file */etc/bind/sunnygo/mecha.franky.E12.com* pada Water7 menggunakan command `nano /etc/bind/sunnygo/mecha.franky.E12.com` lalu tambahkan subdomain untuk file tersebut yang mengarah pada Skypie.  
![(no7)Water7-mecha-franky-E12-com](https://user-images.githubusercontent.com/75328763/139487636-204b69f6-3481-4041-912c-ff85368cc08b.png)  
Lalu restart bind9 dengan command `service bind9 restart`.  
  
2. Lakukan testing dengan `ping general.mecha.franky.E12.com` dan `ping www.general.mecha.franky.E12.com` pada node client.  
![(no7)Loguetown-ping-test](https://user-images.githubusercontent.com/75328763/139488034-d7da0cbb-0ff2-45ad-bef7-a8346d9e7b6b.png)  
  
## Soal 8  
Setelah melakukan konfigurasi server, maka dilakukan konfigurasi Webserver. Pertama dengan webserver *www.franky.E12.com.* Pertama, luffy membutuhkan webserver dengan DocumentRoot pada */var/www/franky.E12.com.*  
  
**Pembahasan :**  
1. Install *apache2* pada Skypie untuk membuat server, beberapa command untuk instalasi sebagai berikut:  
```
apt-get update
apt-get install wget
apt-get install apache2 -y
apt-get install libapache2-mod-php7.0 -y
apt-get install unzip
```  
  
2. Copy file */etc/apache2/sites-available/franky.E12.com.conf* untuk file konfigurasi website pada *franky.E12.com* menggunakan command:  
```
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/franky.E12.com.conf
```  
Lalu edit file */etc/apache2/sites-available/franky.E12.com.conf* dan tambahkan kondigurasi sebagai berikut:  
```
ServerName franky.e14.com
ServerAlias www.franky.e14.com
DocumentRoot /var/www/franky.e14.com
```  
![(no8)Skypie-franky-E12-com-conf](https://user-images.githubusercontent.com/75328763/139490000-811a00c5-2c49-4665-930d-fff2389a4d72.png)  
Lalu aktifkan konfigurasi **franky.E12.com.** tersebut dengan command:  
```
a2ensite franky.E12.com.conf
```  
  
3. Donwload asset yang telah disediakan soal, kemudia extraxt *franky.zip* tersebut dan pindahkan ke */var/www/franky.E12.com* dengan command-command berikut:  
```
wget https://raw.githubusercontent.com/FeinardSlim/Praktikum-Modul-2-Jarkom/main/franky.zip
unzip franky.zip
mv franky /var/www/franky.E12.com
```  
Setelah itu, lakukan restart apache untuk menerapkan konfigurasinya.  
```
service apache2 restart
```  
  
4. Untuk testingnya, install *lynx* pada node client(Alabasta) untuk testing web seperti command berikut:  
```
apt-get update
apt-get install lynx
```  
Setelah itu, lakukan testing `lynx franky.E12.com` dan `lynx www.franky.E12.com` pada node client tersebut.  
![image](https://user-images.githubusercontent.com/75328763/139491919-753af896-1703-4f48-a277-1f6cacab69a1.png)  
  
## Soal 9
Setelah itu, Luffy juga membutuhkan agar url www.franky.yyy.com/index.php/home dapat menjadi www.franky.yyy.com/home.

**Pembahasan :**  
1. Untuk merubah dari www.franky.yyy.com/index.php/home menjadi www.franky.yyy.com/home kita akan merubahkan file `/etc/apache2/sites-available/franky.E12.com.conf`. Maka, kita akan mengakses `/etc/apache2/sites-available/franky.E12.com.conf` terlebih dahulu dengan menggunakan nano seperti berikut
![image](https://user-images.githubusercontent.com/55140514/139530693-f4a6cae8-c5f0-4ffc-8104-d8bcc20beb5a.png)

2. Lalu dalam file tersebut kita edit agar menambahkan bagian
```
Alias "/home" "/var/www/franky.E12.com/index.php/home"
```
dimana akan mengubah menjadi www.franky.E12.com/home sebagai *Alias*
![image](https://user-images.githubusercontent.com/55140514/139530775-e96fc78a-9f02-4db3-bbc5-fc51cec39df8.png)

3. Lalu, kita lakukan `service apache2 restart` dan lakukan pengujian menggunakan lynx di *Loguetown* dengan memasukkan www.franky.E12.com/home berhasil atau tidak seperti berikut
![image](https://user-images.githubusercontent.com/55140514/139530855-023890a4-f2d1-4eef-ae29-d3be6bd692af.png)

dan hasilnya sebagai berikut

![image](https://user-images.githubusercontent.com/55140514/139530873-656963af-51e3-4cb1-a266-d83e975e8dbe.png)

## Soal 10
Setelah itu, pada subdomain www.super.franky.yyy.com, Luffy membutuhkan penyimpanan aset yang memiliki DocumentRoot pada /var/www/super.franky.yyy.com

**Pembahasan :**
1. Langkah pertama kita membuat file `super.franky.E12.com.conf` terlebih dahulu dengan melakukan copy dari `000-default.conf` ke `super.franky.E12.com.conf`

![image](https://user-images.githubusercontent.com/55140514/139531197-d264288b-80a4-4961-b3b9-82feef5c2d76.png)
2. Lalu kita buka file tersebut dan merubahkan isi seperti membuat domain seperti di nomor 8, disini kita akan mengisikan dengan berikut
```
ServerAdmin webmaster@localhost
        DocumentRoot /var/www/super.franky.E12.com
        ServerName super.franky.E12.com
        ServerAlias www.super.franky.E12.com
```
![image](https://user-images.githubusercontent.com/55140514/139531281-1c3cf2a3-2645-4ebb-bece-5f2aea8c74fa.png)

3. Lalu, kita enable kan konfigurasi tersebut dengan `a2ensite`

4. setelah itu kita lakukan restart apache dan melakukan aksi copy file yang ada dari folder `super.franky` yang ada di directory `Praktikum-Modul-2-Jarkom-main` agar website mempunyai isi yang ada pada folder super.franky
```
cd Prakitikum-Modul-2-Jarkom-main
cp -r super.franky /var/www/super.franky.E12.com
cd /var/www/super.franky.E12.com
mv index.php /var/www/super.franky.E12.com
mv home.html /var/www/super.franky.E12.com
```
![image](https://user-images.githubusercontent.com/55140514/139531434-4b3060fd-67ba-4a74-b6fc-22e4b88ef4d5.png)

5. Terakhir kita lakukan testing dengan lynx mengarah ke www.super.franky.E12.com ddengan
```
lynx www.super.franky.E12.com
```
Dan hasil seperti berikut

![image](https://user-images.githubusercontent.com/55140514/139531541-056bd1fe-7e35-42cb-b56f-b4f819493099.png)

## Soal 11
Akan tetapi, pada folder /public, Luffy ingin hanya dapat melakukan directory listing saja.

**Pembahasan :**
1. Pada soal ini kita diminta untuk mengaktifkan directory listing pada folder `/public` yang ada di web www.super.franky.E12.com . Untuk itu langkah pertama yang kita lakukan adalah membuka file konfigurasi super.franky.E12.com dan menambahkan
```
        <Directory /var/www/super.franky.E12.com/public>
                Options +Indexes
        </Directory>
```
Dimana **+Indexes** akan merubah foler `/public` yang ada pada `/var/www/super.frankt.E12.com` menjadi directory listed
![image](https://user-images.githubusercontent.com/55140514/139531799-8d55c188-1ed1-48ab-b045-74470ff0fc5f.png)

2. Lalu, kita lakukan `service apache2 restart` serta testing pada lynx menuju *super.franky.E12.com/public* dan hasil seperti berikut
![image](https://user-images.githubusercontent.com/55140514/139531828-fc4c0c36-cb03-4753-ab8f-0f7c07ab16da.png)

## Soal 12
Tidak hanya itu, Luffy juga menyiapkan error file 404.html pada folder /error untuk mengganti error kode pada apache .

**Pembahasan :**
1. 
## Soal 15
Dengan autentikasi username luffy dan password onepiece dan file di /var/www/general.mecha.franky.e14.

**Pembahasan :**
1. Edit file */etc/apache2/sites-available/general.mecha.franky.e14.com.conf*, lalu tambahkan konfigurasi seperti dibawah.
```
<Directory /var/www/general.mecha.franky.e14.com>
   AuthType Basic
   AuthName "Private"
   AuthUserFile /etc/apache2/.htpasswd
   Require valid-user
</Directory>
```
[Foto15]
2. Jalankan command berikut. Command berikut memiliki arti bahwa kita ingin autentikasi baru dengan nama *Luffy*. Masukkan dan confirm *onepiece* sebagai password dari autentikasi. 
```
htpasswd -c /etc/apache2/.htpasswd luffy
```
3. Restart apache2 untuk menerapkan konfigurasi.
```
service apache2 restart
```
4. Lakukan testing dengan command *lynx general.mecha.franky.e14.com* dan *lynx wwww.general.mecha.franky.e14.com* pada Alabasta atau Loguetown.
[Foto15]
## Soal 16
Dan setiap kali mengakses IP Skypie akan dialihkan secara otomatis ke www.franky.yyy.com.

**Pembahasan :**
1.
## Soal 17
Dikarenakan Franky juga ingin mengajak temannya untuk dapat menghubunginya melalui website www.super.franky.yyy.com, dan dikarenakan pengunjung web server pasti akan bingung dengan randomnya images yang ada, maka Franky juga meminta untuk mengganti request gambar yang memiliki substring “franky” akan diarahkan menuju franky.png.

**Pembahasan :**
1. Edit file */etc/apache2/sites-available/super.franky.e14.com.conf*, lalu tambahkan konfigurasi berikut.
```
<Directory /var/www/super.franky.e14.com>
   Options +Indexes +FollowSymLinks -MultiViews
   AllowOverride All
</Directory>
```
[foto17]
2. Jalan kan ```a2enmod rewrite``` untuk mengaktifkan mod rewrite. Kemudian buat file */var/www/seper.franky.e14.com/.htaccess"* dengan menambahkan konfigurasi berikut didalam file.
```
RewriteEngine On
RewriteCond %{REQUEST_URI} ^/public/images/(.*)franky(.*)
RewriteCond %{REQUEST_URI} !/public/images/franky.png
RewriteRule /.* http://super.franky.e14.com/public/images/franky.png [L]
```
3. Restart apache untuk menerapkan kofigurasi yang telah dibuat.
```
service apache2 restart
```
4. Lakukan testing lynx *super.franky.e14.com/public/images/punkyfranky.png* pada Loguetown.
[Foto17]
