program Aplikasi_Koperasi;
uses crt,sysutils;
const
     maks=100;
     maksPinjaman=1000;
     maks_menu=12;
     garis_kiri=5;
     garis_kanan=60;
     garis_atas=3;
     garis_bawah=17;
     atas=#72;
     bawah=#80;
     enter=#13;
     kiri=#75;
     kanan=#77;
type
    TAnggota=record
                   id_anggota:string;
                   nama:string;
                   alamat:string;
                   no_telp:string;
                   pekerjaan:string;
                   saldo:real;
    end;
    TPinjaman=record
                   kd_pinjaman:string;
                   id_anggota:string;
                   tgl_pinjam:string;
                   jml_pinjam:real;
                   lama:integer;
                   bunga:real;
                   total:real;
                   angsuran:real;
    end;

    data_menu=array[1..maks_menu] of string;

var
   data_anggota:Array[1..maks] of TAnggota;
   data_pinjaman:Array[1..maksPinjaman] of TPinjaman;
   Tmenu:data_menu;
   bd,bdpinjam,pil:integer;
   YYYY,MM,DD : Word;



//----------------------------------------------------------------------------------------------------------------------
//FRAME
//----------------------------------------------------------------------------------------------------------------------
procedure kotak(kiri,kanan,atas,bawah:integer;
                latar,tulisan:integer;judul:string);
var
   i:integer;
begin
     textcolor(tulisan);textbackground(latar);
     window(kiri,atas,kanan,bawah);
     clrscr;
     window(1,1,120,30);
     gotoxy(kiri,atas);write(chr(218));
     gotoxy(kanan,atas);write(chr($BF));
     gotoxy(kiri,bawah);write(#192);
     gotoxy(kanan,bawah);write(#217);
     for i:=kiri+1 to kanan-1 do
     begin
          gotoxy(i,atas);write(#196);gotoxy(i,bawah);write(#196);
     end;
     for i:=atas+1 to bawah-1 do
     begin
          gotoxy(kiri,i);write(#179);gotoxy(kanan,i);write(#179);
     end;
     gotoxy(((kanan-kiri)-length(judul)) div 2+kiri, atas+1);write(judul);
end;

procedure pemisah(kiri,kanan,atas:integer);
var
   i:integer;
begin
     gotoxy(kiri,atas);write(#195);
     for i:=kiri+1 to kanan-1 do
     begin
          gotoxy(i,atas);write(#196);
     end;
     gotoxy(kanan,atas);write(#180);
     writeln;
end;

procedure bersihin();
var
   i:integer;
begin
     textcolor(0);textbackground(0);
     window(1,1,120,30);
     clrscr;
end;

//----------------------------------------------------------------------------------------------------------------------






//----------------------------------------------------------------------------------------------------------------------
//TAMBAH ANGGOTA
//----------------------------------------------------------------------------------------------------------------------
procedure tambah_Anggota;
begin
     clrscr;
     bersihin;
     if bd<maks then
     begin
          kotak(4,50,2,20,BLUE,WHITE,'Tambah Data Anggota');
          pemisah(4,50,2+2);

          bd:=bd+1;
          writeln('Masukan Data Anggota Ke-',bd);
          write('Kode Anggota : ');readln(data_anggota[bd].id_anggota);
          write('Nama Anggota : ');readln(data_anggota[bd].nama);
          write('Alamat       : ');readln(data_anggota[bd].alamat);
          write('No Telepon   : ');readln(data_anggota[bd].no_telp);
          write('pekerjaan    : ');readln(data_anggota[bd].pekerjaan);

     end
     else
     begin
          writeln('Data Penuh. Tekan Enter Untuk Melanjutkan');readln;
     end;
end;
//----------------------------------------------------------------------------------------------------------------------



//----------------------------------------------------------------------------------------------------------------------
//SIMPAN SALDO
//----------------------------------------------------------------------------------------------------------------------
procedure simpanan;
var
   id:string;
   i,index:integer;
   ketemu:boolean;
   insaldo:real;
begin
     clrscr;
     writeln('Simpan Saldo');
     writeln('Masukan Data Anggota');
     write('ID Anggota : ');readln(id);
     for i:=1 to bd do
         if id = data_anggota[i].id_anggota then
         begin
              ketemu:=true;
              index:=i;
         end;
         if ketemu = true then
         begin
              writeln('Nama Anggota : ',data_anggota[index].nama);
              writeln('Alamat       : ',data_anggota[index].alamat);
              writeln('Saldo        : Rp.',data_anggota[index].saldo:0:2);

              writeln;
              writeln;
              write('Tambahkan Saldo : Rp.');read(insaldo);
              data_anggota[index].saldo:=data_anggota[index].saldo + insaldo;
              writeln('Saldo Akhir    : Rp.',data_anggota[index].saldo:0:2);
              readln;
          end
          else
              writeln('Data Tidak Ditemukan');
          readln;
end;
//----------------------------------------------------------------------------------------------------------------------



//----------------------------------------------------------------------------------------------------------------------
//PENARIKAN SALDO
//----------------------------------------------------------------------------------------------------------------------
procedure tarik_saldo;
var
   id:string;
   i,index:integer;
   ketemu:boolean;
   insaldo:real;
   tempsaldo:real;
begin
     clrscr;
     writeln('Penarikan Saldo');
     writeln('Masukan Data Anggota');
     write('ID Anggota : ');readln(id);
     for i:=1 to bd do
         if id = data_anggota[i].id_anggota then
         begin
              ketemu:=true;
              index:=i;
         end;
         if ketemu = true then
         begin
              writeln('Nama Anggota : ',data_anggota[index].nama);
              writeln('Alamat       : ',data_anggota[index].alamat);
              writeln('Saldo        : Rp.',data_anggota[index].saldo:0:2);

              tempsaldo:= data_anggota[index].saldo;
              writeln;
              writeln;
              write('Ambil Saldo : Rp.');read(insaldo);
              if insaldo > tempsaldo then
                 writeln('Saldo Anda Kurang')
              else
                  tempsaldo := tempsaldo - insaldo;

              data_anggota[index].saldo:=tempsaldo;
              writeln('Saldo Akhir    : Rp.',data_anggota[index].saldo:0:2);
              readln;
          end
          else
              writeln('Data Tidak Ditemukan');
          readln;
end;




//----------------------------------------------------------------------------------------------------------------------



//----------------------------------------------------------------------------------------------------------------------
//TAMPIL DATA ANGGOTA
//----------------------------------------------------------------------------------------------------------------------
procedure tampil_dataAnggota;
var
   i:integer;
begin
     clrscr;
     //writeln('-------------------------------------------------------');
     gotoxy(6,6);writeln('ID Anggota ',#179,' Nama Anggota ',#179,'   Alamat   ',#179,'       No.Telp       ',#179,'     Pekerjaan    ',#179,'    Saldo    ');
     for i:=1 to bd do
     begin
         writeln(data_anggota[i].id_anggota:10,'     ',data_anggota[i].nama:12,'       ',data_anggota[i].alamat:10,'        ',data_anggota[i].no_telp:12,'        ',data_anggota[i].pekerjaan:11,'       Rp.',data_anggota[i].saldo:0:2);
     end;
     readln;
end;
//----------------------------------------------------------------------------------------------------------------------




//----------------------------------------------------------------------------------------------------------------------
//TAMPIL DATA PINJAMAN
//----------------------------------------------------------------------------------------------------------------------
procedure tampil_pinjaman;
var
   i:integer;
begin
     clrscr;
     //writeln('-------------------------------------------------------');
     writeln('  Kode ',#179,' ID Anggota ',#179,'  Tanggal  ',#179,' Nominal Pinjam  ',#179,'    Lama   ',#179,' Bunga ',#179,'      Total      ',#179,'    Angsuran    ');
     for i:=1 to bdpinjam do
     begin
         writeln(' ',data_pinjaman[i].kd_pinjaman,'      ',data_pinjaman[i].id_anggota,'       ',data_pinjaman[i].tgl_pinjam,'    Rp.',data_pinjaman[i].jml_pinjam:0:0,'          ',data_pinjaman[i].lama,' Bulan    ',data_pinjaman[i].bunga:0:0,'%      Rp.',data_pinjaman[i].total:0:0,'        Rp.',data_pinjaman[i].angsuran:0:0);
     end;
     readln;
end;



//----------------------------------------------------------------------------------------------------------------------





//----------------------------------------------------------------------------------------------------------------------
//UBAH DATA ANGGOTA
//----------------------------------------------------------------------------------------------------------------------
var
   terpilih:integer;
   tombol:char;

procedure tulis_menuUbah;
var
   i:integer;
begin
     writeln('ID Anggota ',#179,' Nama Anggota ');
     for i:=1 to bd do
         begin
              if terpilih = i then
              begin
                   textbackground(4);
                   writeln('  ',data_anggota[i].id_anggota,'      ',#179,'  ',data_anggota[i].nama);
              end
              else
              begin
                   textbackground(0);
                   writeln('  ',data_anggota[i].id_anggota,'      ',#179,'  ',data_anggota[i].nama);
              end;

     end;
end;

procedure ubah_Anggota(index:integer);
var
   nama,alamat,no_telp,pekerjaan:string;
begin

     writeln('Data yang Mau Di Ubah ID : ',data_anggota[index].id_anggota);
     writeln('Kosongkan yang tidak diubah');
     write('Nama       : ',data_anggota[index].nama,'   Ubah  : ');readln(nama);
     write('Alamat     : ',data_anggota[index].alamat,'   Ubah  : ');readln(alamat);
     write('No Telepon : ',data_anggota[index].no_telp,'   Ubah  : ');readln(no_telp);
     write('pekerjaan  : ',data_anggota[index].pekerjaan,'   Ubah  : ');readln(pekerjaan);
     if nama<>'' then
        data_anggota[index].nama:=nama;
     if alamat<>'' then
        data_anggota[index].alamat:=alamat;
     if no_telp<>'' then
        data_anggota[index].no_telp:=no_telp;
     if pekerjaan<>'' then
        data_anggota[index].pekerjaan:=pekerjaan;
     readln;

end;

procedure pilih_AnggotaUbah;
var
   i:integer;
begin
     terpilih:=1;
     repeat
     clrscr;
     tulis_menuUbah;

     tombol:=readkey;
     if tombol=bawah then
     begin
          if terpilih <> bd then
             terpilih:=terpilih+1;
     end

     else if tombol=atas then
     begin
          terpilih:=terpilih-1;
          if terpilih = 0 then
             terpilih:=terpilih+1;
     end
     else if tombol=enter then
     begin
          clrscr;
          ubah_Anggota(terpilih);
     end;


     //readln(i);
     //terpilih:=i;
     until tombol=enter;
end;

//----------------------------------------------------------------------------------------------------------------------





//----------------------------------------------------------------------------------------------------------------------
//HAPUS DATA ANGGOTA
//----------------------------------------------------------------------------------------------------------------------
var
   terpilih2:integer;

procedure tulis_menuHapus;
var
   i:integer;
begin
     writeln('ID Anggota ',#179,' Nama Anggota ');
     for i:=1 to bd do
         begin
              if terpilih2 = i then
              begin
                   textbackground(4);
                   writeln('  ',data_anggota[i].id_anggota,'      ',#179,'  ',data_anggota[i].nama);
              end
              else
              begin
                   textbackground(0);
                   writeln('  ',data_anggota[i].id_anggota,'      ',#179,'  ',data_anggota[i].nama);
              end;

     end;
end;

procedure hapus_Anggota(index:integer);
var
   yt:char;
   x:integer;
   temp:TAnggota;
begin
     write('Hapus Data ID:',data_anggota[index].id_anggota,'  Atas Nama : ',data_anggota[index].nama,' ?(y/t)');
     read(yt);
     if upcase(yt) = 'Y' then
     begin
          temp:=data_anggota[index+1];
          for x:=index to bd do
          begin
               data_anggota[x]:=temp;
               temp:=data_anggota[index+x+1];
          end;
        bd:=bd-1;
     end
     else if upcase(yt) = 'T' then
          readln;
end;

procedure pilih_AnggotaHapus;
var
   i:integer;
begin
     terpilih2:=1;
     repeat
     clrscr;
     tulis_menuHapus;

     tombol:=readkey;
     if tombol=bawah then
     begin
          if terpilih2 <> bd then
             terpilih2:=terpilih2+1;
     end

     else if tombol=atas then
     begin
          terpilih2:=terpilih2-1;
          if terpilih2 = 0 then
             terpilih2:=terpilih2+1;
     end
     else if tombol=enter then
     begin
          clrscr;
          hapus_Anggota(terpilih2);
     end;


     //readln(i);
     //terpilih:=i;
     until tombol=enter;
end;



//----------------------------------------------------------------------------------------------------------------------





//----------------------------------------------------------------------------------------------------------------------
//PENGURUTAN DATA ANGGOTA
//----------------------------------------------------------------------------------------------------------------------
procedure pengurutan_namaAnggota();
var
   i,j:integer;
   temp:TAnggota;
begin
   for i:=1 to bd-1 do
   begin
        for j:=bd downto i+1 do
        begin
             if data_anggota[j].nama < data_anggota[j-1].nama then
             begin
                  temp:=data_anggota[j];
                  data_anggota[j]:=data_anggota[j-1];
                  data_anggota[j-1]:=temp;
             end;
        end;
   end;
   writeln('Pengurutan Selesai. Tekan Enter untuk melanjutkan');readln;
end;

procedure pengurutan_Anggota;
var
   pil:integer;
begin
     clrscr;
     writeln('1. Pengurutan Berdasarkan ID');
     writeln('2. Pengurutan Berdasarkan Nama Anggota');
     writeln('3. Pengurutan Berdasarkan Alamat');
     writeln('----------------------------------------');
     write('Pilihan : ');readln(pil);
     case pil of
          1: ;
          2: pengurutan_namaAnggota;
          3: ;
     end;
end;
//----------------------------------------------------------------------------------------------------------------------




//----------------------------------------------------------------------------------------------------------------------
//PINJAMAN
//----------------------------------------------------------------------------------------------------------------------
procedure pinjaman;
var
   id:string;
   i,index,lama:integer;
   ketemu:boolean;
   tanggal,kdpinjam:string;
   nominal,bunga,total,angsuran:real;
   tbunga:real;


begin
     clrscr;
     writeln('Pinjaman');
     writeln('Masukan Data Anggota');
     write('ID Anggota : ');readln(id);
     for i:=1 to bd do
         if id = data_anggota[i].id_anggota then
         begin
              ketemu:=true;
              index:=i;
         end;
         if ketemu = true then
         begin
              writeln('Nama Anggota : ',data_anggota[index].nama);
              writeln('Alamat       : ',data_anggota[index].alamat);
              writeln('Saldo        : Rp.',data_anggota[index].saldo:0:2);


              writeln;
              bdpinjam:=bdpinjam+1;
              kdpinjam:='PJ00';
              data_pinjaman[bdpinjam].kd_pinjaman:=kdpinjam+IntToStr(bdpinjam);
              Writeln ('Kode Pinjaman : ',data_pinjaman[bdpinjam].kd_pinjaman);

              data_pinjaman[bdpinjam].id_anggota:=data_anggota[index].id_anggota;


              DeCodeDate (Date,YYYY,MM,DD);
              tanggal:=format('%d/%d/%d',[dd,mm,yyyy]);
              Writeln ('Tanggal Pinjam : ',tanggal);
              data_pinjaman[bdpinjam].tgl_pinjam:=tanggal;

              write('Masukan Nominal Pinjam : Rp.');readln(nominal);
              write('Lama Pinjaman(Bulan) : ');readln(lama);
              write('Bunga(Persen) : ');readln(bunga);
              tbunga:=(bunga/100)*nominal;

              total:=nominal+tbunga;
              writeln('Total : Rp.',total:0:0);

              angsuran:=total/lama;
              writeln('Angsuran : Rp.',angsuran:0:0);

              data_pinjaman[bdpinjam].jml_pinjam:=nominal;
              data_pinjaman[bdpinjam].lama:=lama;
              data_pinjaman[bdpinjam].bunga:=bunga;
              data_pinjaman[bdpinjam].total:=total;
              data_pinjaman[bdpinjam].angsuran:=angsuran;

              readln;
          end
          else
              writeln('Data Tidak Ditemukan');
          readln;
end;
//----------------------------------------------------------------------------------------------------------------------





//----------------------------------------------------------------------------------------------------------------------
procedure simpansemuafile;
var
   i,x:integer;
   f:file of TAnggota;
   fp:file of TPinjaman;
begin
     assign(f,'FileAnggota.dat');
     rewrite(f);
     for i:=1 to bd do
         write(f,data_anggota[i]);
     assign(fp,'FilePinjaman.dat');
     rewrite(fp);
     for x:=1 to bdpinjam do
         write(fp,data_pinjaman[x]);
     writeln(bd,'Data Telah Disimpan Ke File');
     readln;
end;
//----------------------------------------------------------------------------------------------------------------------



//----------------------------------------------------------------------------------------------------------------------
procedure bacasemuafile;
var
   f:file of TAnggota;
   fp:file of TPinjaman;
begin
     if fileexists('FileAnggota.dat') then
     begin
          assign(f,'FileAnggota.dat');
          reset(f);
          while not eof(f) do
          begin
               bd:=bd+1;
               read(f,data_anggota[bd]);
          end;
          close(f);
          writeln('Baca data selesai. Jumlah Anggota : ',bd,' record');
          readln;
     end
     else
     begin
          write('File Belum Ada. Tidak ada data yang terbaca');readln;
     end;

     if fileexists('FilePinjaman.dat') then
     begin
          assign(fp,'FilePinjaman.dat');
          reset(fp);
          while not eof(fp) do
          begin
               bdpinjam:=bdpinjam+1;
               read(fp,data_pinjaman[bdpinjam]);
          end;
          close(fp);
          writeln('Baca data selesai. Jumlah Pinjaman : ',bdpinjam,' record');
          readln;
     end
     else
     begin
          write('File Belum Ada. Tidak ada data yang terbaca');readln;
     end;


end;
//----------------------------------------------------------------------------------------------------------------------


//----------------------------------------------------------------------------------------------------------------------
procedure pencarian_namaAnggota;
var
   cari:string;
   L,R,T:integer;
   ketemu:boolean;
begin
     pengurutan_namaAnggota;
     writeln('Masukan Nama Anggota');readln(cari);
     L:=1;
     R:=bd;
     T:=(L+R) div 2;
     while (upcase(data_anggota[T].nama) <> upcase(cari)) and (L<=R) do
     begin
          if upcase(data_anggota[T].nama)>upcase(cari) then
             R:=T-1
          else
              L:=T+1;
          T:=(L+R) div 2;
     end;
     if upcase(data_anggota[T].nama) = upcase(cari) then
     begin
        writeln(cari,' ditemukan di indeks ke-',T);
        writeln('Nama Anggota : ',data_anggota[T].nama);
     end
     else
        writeln(cari,' tidak ditemukan');
     readln;
end;
//----------------------------------------------------------------------------------------------------------------------





//----------------------------------------------------------------------------------------------------------------------
//MENU
//----------------------------------------------------------------------------------------------------------------------
procedure isi_menu;
begin
     Tmenu[1]:='  1. Tambah Data Anggota        ';
     Tmenu[2]:='  2. Tampilkan Data Anggota     ';
     Tmenu[3]:='  3. Pengurutan Data Anggota    ';
     Tmenu[4]:='  4. Pencarian Data Anggota     ';
     Tmenu[5]:='  5. Ubah Data Anggota          ';
     Tmenu[6]:='  6. Hapus Data Anggota         ';
     Tmenu[7]:='  7. Simpanan                   ';
     Tmenu[8]:='  8. Pinjaman                   ';
     Tmenu[9]:='  9. Penarikan Saldo            ';
     Tmenu[10]:='  10. Tampilkan Data Pinjaman  ';
     Tmenu[11]:='  11. Simpan Kedalam File      ';
     Tmenu[11]:='  12. Keluar                   ';
end;

procedure tulis_menu;
var
   i:integer;
begin
for i:=1 to maks_menu do
     begin
          if terpilih = i then
          begin
               textbackground(4);
               writeln(Tmenu[i]);
          end
          else
          begin
               textbackground(blue);
               writeln(Tmenu[i]);

          end;

     end;
end;

procedure buka_menu(t:integer);
begin
     case t of
          1:tambah_Anggota;
          2:tampil_dataAnggota;
          3:;
          4:;
          5:pilih_AnggotaUbah;
          6:pilih_AnggotaHapus;
          7:simpanan;
          8:pinjaman;
          9:tarik_saldo;
          10:tampil_pinjaman;
          11:simpansemuafile;
     end;
end;

procedure seleksi_menu;
begin
     terpilih:=1;
     repeat
           clrscr;
           isi_menu;
           tulis_menu;

           tombol:=readkey;
           if tombol=bawah then
           begin
                if terpilih < maks_menu then
                   terpilih:=terpilih+1;
           end
           else if tombol=atas then
           begin
                terpilih:=terpilih-1;
                if terpilih = 0 then
                   terpilih:=terpilih+1;
           end
           else if tombol=enter then
           begin
                clrscr;
                buka_menu(terpilih);
           end;

     until tombol=enter;
end;


//----------------------------------------------------------------------------------------------------------------------





//----------------------------------------------------------------------------------------------------------------------
//MULAI DISINI
//----------------------------------------------------------------------------------------------------------------------
begin
     bd:=0;
     bdpinjam:=0;
     bacasemuafile;

     repeat
     bersihin;
     clrscr;
     kotak(3,70,2,20,BLUE,WHITE,'Aplikasi Koperasi');
     pemisah(3,70,4);

     window(5,5,67,19);
     seleksi_menu;

     readln;
     until terpilih=12;
     simpansemuafile;
     readln;
end.
