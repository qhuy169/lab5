-- Query 1
SELECT HoSV + N' ' + TenSV AS HoTenSinhVien, MaKH AS MaKhoa, NoiSinh, HocBong
FROM SinhVien
WHERE HocBong > 100000 AND NoiSinh = N'Tp. HCM';

-- Query 2
SELECT MaSV AS MaSinhVien, MaKH AS MaKhoa, 
       CASE WHEN Phai = 1 THEN N'Nữ' ELSE N'Nam' END AS Phai
FROM SinhVien
WHERE MaKH IN (N'AV', N'TR');

-- Query 3
SELECT MaSV AS MaSinhVien, NgaySinh, NoiSinh, HocBong
FROM SinhVien
WHERE NgaySinh BETWEEN '1986-01-01' AND '1992-06-05';

-- Query 4
SELECT MaSV AS MaSinhVien, NgaySinh, 
       CASE WHEN Phai = 1 THEN N'Nữ' ELSE N'Nam' END AS Phai, MaKH AS MaKhoa
FROM SinhVien
WHERE HocBong BETWEEN 200000 AND 800000;

-- Query 5
SELECT MaMH AS MaMonHoc, TenMH AS TenMonHoc, SoTiet
FROM MonHoc
WHERE SoTiet > 40 AND SoTiet < 60;

-- Query 6
SELECT MaSV AS MaSinhVien, HoSV + N' ' + TenSV AS HoTenSinhVien, N'Nam' AS Phai
FROM SinhVien
WHERE MaKH = N'AV' AND Phai = 0;

-- Query 7
SELECT HoSV + N' ' + TenSV AS HoTenSinhVien, TenSV, NoiSinh, NgaySinh
FROM SinhVien
WHERE NoiSinh = N'Hà Nội' AND NgaySinh > '1990-01-01';

-- Query 8
SELECT HoSV + N' ' + TenSV AS HoTenSinhVien
FROM SinhVien
WHERE Phai = 1 AND TenSV LIKE N'%N%';

-- Query 9
SELECT MaSV AS MaSinhVien, HoSV + N' ' + TenSV AS HoTenSinhVien, NgaySinh
FROM SinhVien
WHERE MaKH = N'TH' AND NgaySinh > '1986-05-30';

-- Query 10
SELECT HoSV + N' ' + TenSV AS HoTenSinhVien, 
       CASE WHEN Phai = 1 THEN N'Nữ' ELSE N'Nam' END AS GioiTinh, 
       NgaySinh
FROM SinhVien;

-- Query 11
SELECT MaSV AS MaSinhVien, 
       YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi, 
       NoiSinh, 
       MaKH AS MaKhoa
FROM SinhVien;

-- Query 12
SELECT HoSV + N' ' + TenSV AS HoTenSinhVien, 
       YEAR(GETDATE()) - YEAR(NgaySinh) AS Tuoi, 
       TenKH AS TenKhoa
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE YEAR(GETDATE()) - YEAR(NgaySinh) BETWEEN 20 AND 30;

-- Query 13
SELECT MaSV AS MaSinhVien, 
       CASE WHEN Phai = 1 THEN N'Nữ' ELSE N'Nam' END AS Phai, 
       MaKH AS MaKhoa, 
       CASE WHEN HocBong > 500000 THEN N'Học bổng cao' ELSE N'Mức trung bình' END AS MucHocBong
FROM SinhVien;

-- Query 14
SELECT HoSV + N' ' + TenSV AS HoTenSinhVien, 
       CASE WHEN Phai = 1 THEN N'Nữ' ELSE N'Nam' END AS GioiTinh, 
       TenKH AS TenKhoa
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE TenKH = N'Anh Văn';

-- Query 15
SELECT TenKH AS TenKhoa, 
       HoSV + N' ' + TenSV AS HoTenSinhVien, 
       TenMH AS TenMonHoc, 
       SoTiet, 
       Diem
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
WHERE Khoa.MaKH = N'TH';

-- Query 16
SELECT HoSV + N' ' + TenSV AS HoTenSinhVien, 
       MaKH AS MaKhoa, 
       TenMH AS TenMonHoc, 
       Diem AS DiemThi, 
       CASE 
           WHEN Diem > 8 THEN N'Giỏi' 
           WHEN Diem BETWEEN 6 AND 8 THEN N'Khá' 
           ELSE N'Trung Bình' 
       END AS Loai
FROM SinhVien
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH;

-- Query 17
SELECT MaKH AS MaKhoa, 
       TenKH AS TenKhoa, 
       MAX(HocBong) AS HocBongCaoNhat
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY MaKH, TenKH;

-- Query 18
SELECT MonHoc.MaMH AS MaMon, 
       MonHoc.TenMH AS TenMon, 
       COUNT(DISTINCT Ketqua.MaSV) AS SoSinhVienDangHoc
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH;

-- Query 19
SELECT MonHoc.TenMH AS TenMon, 
       MonHoc.SoTiet, 
       SinhVien.HoSV + N' ' + SinhVien.TenSV AS TenSinhVien, 
       Ketqua.Diem
FROM Ketqua
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
WHERE Ketqua.Diem = (SELECT MAX(Diem) FROM Ketqua);

-- Query 20
SELECT TOP 1 MaKH AS MaKhoa, 
             TenKH AS TenKhoa, 
             COUNT(*) AS TongSoSinhVien
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY MaKH, TenKH
ORDER BY TongSoSinhVien DESC;

-- Query 21
SELECT Khoa.TenKH AS TenKhoa, 
       SinhVien.HoSV + N' ' + SinhVien.TenSV AS HoTenSinhVien, 
       SinhVien.HocBong
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE SinhVien.HocBong = (SELECT MAX(HocBong) FROM SinhVien);

-- Query 22
SELECT SinhVien.MaSV AS MaSinhVien, 
       SinhVien.HoSV, 
       SinhVien.TenSV, 
       Khoa.TenKH AS TenKhoa, 
       SinhVien.HocBong
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE Khoa.MaKH = N'TH' 
  AND SinhVien.HocBong = (SELECT MAX(HocBong) 
                          FROM SinhVien 
                          WHERE MaKH = N'TH');

-- Query 23
SELECT SinhVien.HoSV + N' ' + SinhVien.TenSV AS HoTenSinhVien, 
       MonHoc.TenMH AS TenMon, 
       Ketqua.Diem
FROM Ketqua
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
WHERE MonHoc.TenMH = N'Cơ sở dữ liệu' 
  AND Ketqua.Diem = (SELECT MAX(Diem) 
                     FROM Ketqua 
                     JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH 
                     WHERE MonHoc.TenMH = N'Cơ sở dữ liệu');

-- Query 24
SELECT TOP 3 SinhVien.HoSV + N' ' + SinhVien.TenSV AS HoTenSinhVien, 
             Khoa.TenKH AS TenKhoa, 
             MonHoc.TenMH AS TenMon, 
             Ketqua.Diem
FROM Ketqua
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE MonHoc.TenMH = N'Đồ họa ứng dụng'
ORDER BY Ketqua.Diem ASC;

-- Query 25
SELECT SinhVien.HoSV + N' ' + SinhVien.TenSV AS HoTenSinhVien, 
       Khoa.TenKH AS TenKhoa, 
       CASE 
           WHEN NOT EXISTS (
               SELECT 1 
               FROM Ketqua 
               WHERE Ketqua.MaSV = SinhVien.MaSV 
                 AND Ketqua.Diem < 4
           ) 
           THEN N'Đậu' 
           ELSE N'Rớt' 
       END AS KetQua
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH;

-- Query 26
SELECT SinhVien.HoSV + N' ' + SinhVien.TenSV AS HoTenSinhVien, 
       Khoa.TenKH AS TenKhoa, 
       CASE WHEN SinhVien.Phai = 1 THEN N'Nữ' ELSE N'Nam' END AS Phai
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE NOT EXISTS (
    SELECT 1 
    FROM Ketqua 
    WHERE Ketqua.MaSV = SinhVien.MaSV 
      AND Ketqua.Diem < 4
);

-- Query 27
SELECT DISTINCT MonHoc.MaMH AS MaMon, MonHoc.TenMH AS TenMon
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
WHERE Ketqua.MaMH NOT IN (
    SELECT MaMH 
    FROM Ketqua 
    WHERE Diem < 4
);

-- Query 28
SELECT DISTINCT Khoa.MaKH AS MaKhoa, Khoa.TenKH AS TenKhoa
FROM Khoa
JOIN SinhVien ON Khoa.MaKH = SinhVien.MaKH
WHERE NOT EXISTS (
    SELECT 1 
    FROM Ketqua 
    WHERE Ketqua.MaSV = SinhVien.MaSV 
      AND Ketqua.Diem < 5
);

-- Query 29
SELECT MonHoc.MaMH AS MaMon, 
       MonHoc.TenMH AS TenMon,
       SUM(CASE WHEN Ketqua.Diem >= 5 THEN 1 ELSE 0 END) AS SoSinhVienDau,
       SUM(CASE WHEN Ketqua.Diem < 5 THEN 1 ELSE 0 END) AS SoSinhVienRot
FROM Ketqua
JOIN MonHoc ON Ketqua.MaMH = MonHoc.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH;

-- Query 30
SELECT DISTINCT MonHoc.MaMH AS MaMon, MonHoc.TenMH AS TenMon
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
WHERE MonHoc.MaMH NOT IN (
    SELECT MaMH 
    FROM Ketqua 
    WHERE Diem < 5
);

-- Query 31
SELECT MaSV AS MaSinhVien, 
       HoSV + N' ' + TenSV AS HoTenSinhVien, 
       MaKH AS MaKhoa
FROM SinhVien
WHERE NOT EXISTS (
    SELECT 1 
    FROM Ketqua 
    WHERE Ketqua.MaSV = SinhVien.MaSV 
      AND Ketqua.Diem < 5
);

-- Query 32
SELECT MaSV AS MaSinhVien, 
       HoSV, 
       TenSV, 
       MaKH AS MaKhoa
FROM SinhVien
WHERE (SELECT COUNT(*) 
       FROM Ketqua 
       WHERE Ketqua.MaSV = SinhVien.MaSV 
         AND Ketqua.Diem < 5) > 2;

-- Query 33
SELECT MaKH AS MaKhoa, 
       TenKH AS TenKhoa, 
       COUNT(*) AS TongSoSinhVien
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
GROUP BY MaKH, TenKH
HAVING COUNT(*) > 10;

-- Query 34
SELECT MaSV AS MaSinhVien, 
       HoSV + N' ' + TenSV AS HoTenSinhVien, 
       COUNT(MaMH) AS SoMonThi
FROM Ketqua
JOIN SinhVien ON Ketqua.MaSV = SinhVien.MaSV
GROUP BY MaSV, HoSV, TenSV
HAVING COUNT(MaMH) > 4;

-- Query 35
SELECT MaKH AS MaKhoa, 
       TenKH AS TenKhoa, 
       COUNT(*) AS TongSoSinhVienNam
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
WHERE Phai = 0
GROUP BY MaKH, TenKH
HAVING COUNT(*) >= 5;

-- Query 36
SELECT HoSV + N' ' + TenSV AS HoTenSinhVien, 
       TenKH AS TenKhoa, 
       CASE WHEN Phai = 1 THEN N'Nữ' ELSE N'Nam' END AS Phai, 
       AVG(Diem) AS DiemTrungBinh
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
GROUP BY HoSV, TenSV, TenKH, Phai
HAVING AVG(Diem) > 4;

-- Query 37
SELECT MaMH AS MaMon, 
       TenMH AS TenMon, 
       AVG(Diem) AS TrungBinhDiem
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MaMH, TenMH
HAVING AVG(Diem) > 6;

-- Query 38
SELECT SinhVien.HoSV + N' ' + SinhVien.TenSV AS HoTenSinhVien, 
       Khoa.TenKH AS TenKhoa, 
       CASE WHEN SinhVien.Phai = 1 THEN N'Nữ' ELSE N'Nam' END AS Phai, 
       AVG(Ketqua.Diem) AS DiemTrungBinh
FROM SinhVien
JOIN Khoa ON SinhVien.MaKH = Khoa.MaKH
JOIN Ketqua ON SinhVien.MaSV = Ketqua.MaSV
GROUP BY SinhVien.HoSV, SinhVien.TenSV, Khoa.TenKH, SinhVien.Phai
HAVING AVG(Ketqua.Diem) > 4;

-- Query 39
SELECT MonHoc.MaMH AS MaMon, 
       MonHoc.TenMH AS TenMon, 
       AVG(Ketqua.Diem) AS TrungBinhDiem
FROM MonHoc
JOIN Ketqua ON MonHoc.MaMH = Ketqua.MaMH
GROUP BY MonHoc.MaMH, MonHoc.TenMH
HAVING AVG(Ketqua.Diem) > 6;
