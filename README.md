# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------  | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true | 
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| family_name        | string  | null: false               |
| kana_last_name     | string  | null: false               |
| kana_family_name   | string  | null: false               |
| birth_date         | date    | null: false               |

### Association

- has_many : items
- has_many : orders

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| item_name        | string     | null: false                    | 
| information      | text       | null: false                    | 
| category_id      | integer    | null: false                    |
| status_id        | integer    | null: false                    |
| shipping_fee_id  | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| schedule_id      | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to : user
- has_one    : order

## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |


### Association

- belongs_to : item
- belongs_to : user
- has_one    : address

## addresses テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postal_code      | string     | null: false                    |
| prefecture_id    | integer    | null: false                    | 
| city             | string     | null: false                    | 
| house_number     | string     | null: false                    |
| building         | string     |                                |
| phone            | string     | null: false                    |
| order            | references | null: false, foreign_key: true |

### Association

- belongs_to : order