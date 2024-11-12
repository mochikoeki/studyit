import 'package:flutter/material.dart';

class KurmerPage extends StatelessWidget {
  const KurmerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kurikulum Merdeka"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              "Kurikulum Merdeka adalah sebuah sistem pendidikan yang diterapkan di Indonesia dengan tujuan memberikan kebebasan lebih kepada sekolah, guru, dan siswa dalam menentukan dan menjalani proses pembelajaran. Kurikulum ini dirancang untuk memberikan ruang bagi kreativitas, keberagaman, dan otonomi dalam pembelajaran, serta mengurangi penekanan pada ujian dan tes yang berbasis pada angka semata. Kurikulum Merdeka bertujuan untuk menyesuaikan pembelajaran dengan kebutuhan, minat, dan potensi masing-masing siswa agar mereka dapat berkembang secara maksimal.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),
            Text(
              "Komponen Utama Kurikulum Merdeka",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "1. Pendidikan yang Berfokus pada Siswa\n\nKurikulum Merdeka memberikan kesempatan kepada siswa untuk lebih terlibat dalam pembelajaran yang sesuai dengan minat dan kemampuan mereka. Proses pembelajaran menjadi lebih fleksibel dan kontekstual.\n\n2. Proyek Penguatan Profil Pelajar Pancasila\n\nSiswa akan diajak untuk belajar dan berpartisipasi dalam proyek yang mengarah pada penguatan karakter, seperti rasa kebangsaan, toleransi, dan gotong royong. Hal ini bertujuan untuk membentuk pelajar yang memiliki profil sesuai dengan nilai-nilai Pancasila.\n\n3. Fleksibilitas dalam Pengelolaan Waktu dan Materi\n\nKurikulum Merdeka memberikan fleksibilitas bagi sekolah dan guru dalam menentukan materi yang diajarkan, waktu yang digunakan, serta metode pembelajaran yang lebih relevan dengan kebutuhan siswa dan kondisi sekolah.\n\n4. Asesmen yang Menekankan Proses\n\nBerbeda dengan kurikulum sebelumnya yang lebih berfokus pada ujian dan penilaian akhir, Kurikulum Merdeka menekankan pada penilaian berkelanjutan dan proses pembelajaran, yang memungkinkan siswa untuk belajar dari kegagalan dan memperbaiki diri secara terus-menerus.\n\n5. Pembelajaran Berdiferensiasi\n\nKurikulum Merdeka memungkinkan adanya pendekatan pembelajaran yang lebih beragam dan disesuaikan dengan kemampuan dan kebutuhan siswa, termasuk memperhatikan gaya belajar yang berbeda-beda.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),
            Text(
              "Apa yang Menarik dari Kurikulum Merdeka?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "1. Kebebasan dalam Pembelajaran\n\nSalah satu daya tarik utama dari Kurikulum Merdeka adalah kebebasan bagi sekolah dan guru untuk merancang pembelajaran yang sesuai dengan karakteristik dan kebutuhan siswa. Ini berarti bahwa setiap sekolah dapat memiliki pendekatan yang unik, menciptakan suasana belajar yang lebih menyenangkan dan relevan.\n\n2. Fokus pada Pengembangan Karakter dan Kompetensi Sosial\n\nKurikulum ini tidak hanya berfokus pada pencapaian akademik, tetapi juga mengutamakan pembentukan karakter dan kompetensi sosial siswa. Proyek-proyek yang mengarah pada nilai-nilai Pancasila memberikan kesempatan bagi siswa untuk memahami dan mengamalkan nilai-nilai kebangsaan serta pentingnya berinteraksi secara positif dengan masyarakat.\n\n3. Mengurangi Tekanan Ujian\n\nDengan berkurangnya ketergantungan pada ujian akhir, Kurikulum Merdeka memberi lebih banyak kesempatan bagi siswa untuk belajar dengan cara yang lebih alami dan reflektif. Proses pembelajaran menjadi lebih berbasis pada pengalaman, eksperimen, dan pengembangan diri.\n\n4. Pemberdayaan Guru\n\nKurikulum Merdeka memberi guru lebih banyak kebebasan dalam memilih metode dan bahan ajar yang paling efektif untuk siswa. Ini meningkatkan kreativitas guru dalam menciptakan pengalaman belajar yang menyenangkan dan sesuai dengan kebutuhan siswa.\n\n5. Pendekatan yang Lebih Terhubung dengan Kehidupan Nyata\n\nKurikulum Merdeka mendorong pembelajaran yang terhubung langsung dengan kehidupan sehari-hari siswa, mempersiapkan mereka untuk menghadapi tantangan dunia nyata, baik dalam konteks akademik maupun sosial. Pembelajaran tidak hanya berfokus pada teori, tetapi juga pada keterampilan praktis yang dapat diaplikasikan dalam kehidupan mereka.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),
            Text(
              "Kesimpulan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Kurikulum Merdeka menawarkan pendekatan yang lebih fleksibel, relevan, dan menyenangkan dalam pendidikan. Dengan memberi kebebasan kepada sekolah dan guru untuk menyesuaikan pembelajaran dengan karakteristik siswa, kurikulum ini diharapkan dapat menghasilkan generasi pelajar yang tidak hanya unggul dalam pengetahuan, tetapi juga memiliki karakter kuat, kemampuan sosial, dan keterampilan yang siap menghadapi masa depan.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
