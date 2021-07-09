# PVZ-Solar2D (NKNU SE)
## 使用工具
- Vscode
- Solar2D (CoronaSDK的後續作)
- PhotoShop 
## 實作過程
1. PhotoShop 去底白修圖
2. Lua開發遊戲主題，參數參考Wiki和原遊戲測試結果
3. Solar2D模擬

## 待解決問題
- 殭屍出現的隨機性，目前暫使用定點計算，因此關卡殭屍出現順序固定

## 未來更新
- Solar2D支援HTML5 可結合Github pages打造網頁版遊戲

## 程式架構
- main.lua
    - 主程式composer控制切換到menu2
- menu2.lua
    - 遊戲主介面提供選單 開始遊戲、音量調節、退出
- setting2.lua
    - 調節遊戲音量
- startgame2.lua
    - PVZ遊戲主題
