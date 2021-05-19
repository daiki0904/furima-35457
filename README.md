# テーブル設計

## users テーブル

| Column           | Type    | Options                   |
| ---------------- | ------  | ------------------------- |
| nickname         | string  | null: false               |
| email            | string  | null: false               | 
| password         | string  | null: false, unique: true |
| last_name        | string  | null: false               |
| family_name      | string  | null: false               |
| kana_last_name   | string  | null: false               |
| kana_family_name | string  | null: false               |
| year             | integer | null: false               |
| month            | integer | null: false               |
| day              | integer | null: false               |

### Association

- has_many : items
- has_many : records

## items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| image            |            | null: false                    |
| item_name        | string     | null: false                    | 
| explanation      | text       | null: false                    | 
| category         | string     | null: false                    |
| status           | string     | null: false                    |
| delivery_burden  | string     | null: false                    |
| area             | string     | null: false                    |
| days             | string     | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |
| record           | references | null: false, foreign_key: true |

### Association

- belongs_to : user
- has_one    : record

## records テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |
| address | references | null: false, foreign_key: true |


### Association

- belongs_to : item
- belongs_to : user
- belongs_to : address

## addresses テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postal_code      | integer    | null: false                    |
| prefecture       | string     | null: false                    | 
| city             | string     | null: false                    | 
| line_1           | integer    | null: false                    |
| line_2           | string     |                                |
| phone            | integer    | null: false                    |
| record           | references | null: false, foreign_key: true |

### Association

- has_many : records