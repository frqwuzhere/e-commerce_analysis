Analisis kali ini menggunakan data dari dataset e-commerce terbesar di Pakistan, namun sudah mendapatkan beberapa penyesuaian pada datanya. Untuk datasetnya sendiri bisa kalian unduh dari link ini Pakistan's Largest E-Commerce Dataset (kaggle.com).
Jadi setelah mendapatkan penyesuaian, datasetnya dibagi menjadi 4 tabel, yaitu

1. order_detail yang berisi detail order dari tahun 2021 hingga 2022. Untuk kolomnya terdiri dari:
    id = nilai unik dari order id.
    customer_id = id dari customer yang melakukan transaksi.
    order_date = detail waktu (tahun, bulan dan hari) terjadinya transaksi.
    sku_id = id dari produk (sku / stock keeping unit).
    price = harga dari produk terkait.
    qty_ordered = jumlah kuantitas produk yang dibeli dalam suatu transaksi.
    before_discount = harga total yang dibeli (price * qty_ordered) sebelum diskon.
    discount_amount = jumlah diskon.
    after_discount = harga setelah dipotong diskon.
    is_gross = tanda bahwa kustomer belum melakukan pembayaran.
    is_valid = tanda bahwa kustomer sudah melakukan pembayaran.
    is_net = tanda bahwa transaksi sudah selesai.
    payment_id = nilai unik dari bentuk pembayaran.

2. sku detail berisi detail deskripsi dari produk. Untuk kolomnya adalah sebagai berikut:
    id = value unik dari produk.
    sku_name = nama tipe produk.
    base_price = harga awal dari produk.
    cogs = harga pokok penjualan / biaya yang dikeluarkan untuk produksi atau perolehan aset.
    category = kategory dari sebuah produk.

3. payment_detail berisi tentang detail macam-macam jenis pembayaran. Berisi kolom sebagai berikut:
    id = value unik dari jenis payment.
    payment_method = metode / jenis dari pembayaran.

4. customer_detail berisi tentang detail kustomer. Kolomnya adalah sebagai berikut:
    id = value unik dari kustomer.
    registered_date = tanggal kustomer melakukan pendaftaran.
