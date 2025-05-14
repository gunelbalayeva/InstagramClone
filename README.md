#  Instagram Clone (Firebase ilə)

Bu layihə Swift dilində hazırlanmış sadə bir **Instagram klonudur**. Layihə vasitəsilə istifadəçilər qeydiyyatdan keçə, şəkil paylaşa və digər istifadəçilərin paylaşımlarını **like** edə bilirlər. Layihədə **Firebase** texnologiyalarından və populyar Swift kitabxanalarından istifadə olunmuşdur.

##  Əsas Funksionallıqlar

-  **Email ilə qeydiyyat və daxilolma (Sign Up / Sign In)**
-  **İstifadəçi şəkil yükləyə bilir**
-  **İstifadəçilər şəkilləri like edə bilir və like geri alına bilir**
  - Hər istifadəçi bir paylaşımı yalnız **1 dəfə like** edə bilər
-  **İstifadəçi ayarlarında logout funksiyası**
-  **Session yadda saxlanılır** – bir dəfə daxil olduqdan sonra növbəti girişdə avtomatik hesabına yönləndirilir

##  İstifadə olunan texnologiyalar və kitabxanalar

-  **Firebase Authentication** – istifadəçi qeydiyyatı və daxilolma üçün
-  **Cloud Firestore** – şəkil məlumatlarının saxlanılması üçün
-  **Firebase Storage** – şəkillərin saxlanması üçün
-  **SDWebImage** – şəkillərin asinxron yüklənməsi və cache-lənməsi üçün
-  **SnapKit** – UI dizaynını Auto Layout ilə rahat qurmaq üçün

##  Quraşdırma və işlətmə

> Layihəni işə salmaq üçün aşağıdakı addımları yerinə yetirin:

1. Bu repo-nu klonlayın:
   ```bash
   git clone https://github.com/istifadeci/InstagramClone.git
   ```
2. `pod install` və ya `SPM` ilə kitabxanaları yükləyin.
3. `GoogleService-Info.plist` faylını layihəyə əlavə edin.
4. `Xcode` ilə açıb `Run` edin.

