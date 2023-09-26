# Indoor_position_DB
使用PostgreSQL建立資料庫,管理Tag, 天線和器材等資訊，以及天線偵測tag的數據

***
## 場景應用
醫院的ICU病房，根據地理環境劃分為10個區域。透過天線接收到的tag從而判斷器材位列哪一區域。

## DB 架構
![image](https://github.com/jack830503/Indoor_position_DB/blob/main/DB%E6%9E%B6%E6%A7%8B%26Tag%E6%B8%85%E5%96%AE/db.jpg)
<br><br>
- object : 器材資訊
- tag : 射頻標籤
- antenna : 天線資訊
- category : 將不同器材進行分類
- area : 區域id
- detection : 天線測到tag時回傳的數據
- location : 用程式判斷器材位於哪一區後，記錄器材位置

***
## db.py
提供API供前端呈現網頁時撈取資料庫數據

