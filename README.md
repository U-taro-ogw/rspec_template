# このbranchについて
処理速度について気になったため下記状況において各レコード数でどちらが早いか検証した

# 先に結果
|件数|SQL|sampleメソッド|
|---|---|---|
|100|||
|1000|||
|10000|||
|100000|||

### やりたいこと
post parameterの`hoge_category`に当てはまるhogeレコードをランダムに3件返却する

### テーブル
hogesテーブルのレコード例
|id|title|category1|category2|
|---|---|---|---|
|1|hoge1_title|cateA|cateB|
|2|hoge2_title|cateB|null|
|3|hoge3_title|cateC|cateA|
|4|hoge4_title|cateA|null|

### 比較対象
hogeテーブルのレコードがそれぞれ
100
1000
10000
100000
件の時の下記2つの方法の実行時間

1. SQLでランダム取得
```ruby
Hoge.where(category1: params[:hoge_category]).or(Hoge.where(category2: params[:hoge_category])).order("RAND()").limit(3)
```

2. sampleメソッドを使用
```ruby
Hoge.where(category1: params[:hoge_category]).or(Hoge.where(category2: params[:hoge_category])).sample(3)
```
