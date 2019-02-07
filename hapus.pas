procedure hapus_nama;
var
   cari:string;
   i,x:integer;
   temp:TPenjualan;//ini record data nya
begin
     writeln('Masukan Nama Produk');readln(cari);
     i:=1;
     //cari dulu data yang mau dihapus
     while (data[i].kd_barang <> cari) and (i<bd) do   //note bd=banyakdata
           i:=i+1;
     if data[i].kd_barang = cari then
     begin
        writeln(cari,' ditemukan di indeks ke-',i);
        writeln('nama barang : ',data[i].nama);
        data[i]:=data[bd+1];
        temp:=data[i+1];
        for x:=i to bd do
        begin
           data[x]:=temp;
           temp:=data[i+x+1];
        end;
        bd:=bd-1;
       
     end
     else
        writeln(cari,' tidak ditemukan');
     readln;
end;

