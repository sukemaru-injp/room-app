# README

# table

## users

| column       | 型          | option          |
| ------------ | ----------- | --------------- |
| name         | string      | null: false     |
| email        | string      | null: false     |
| password     | string      | null: false     |
| sex_id       | integer     | null: false     |

### association
- has_one :room
- has_many :comments
- has_many :likes


## rooms

| column       | 型          | option            |
| ------------ | ----------- | ----------------- |
| title        | string      | null: false       |
| content      | text        | null: false       |
| place_id     | integer     | null: false       |
| floor_id     | integer     | null: false       |
| style_id     | integer     | null: false       |
| user         | references  | foreign_key: true |

### association

- belongs_to :user
- has_many :room_tag_relations
- has_many :tags, through: :room_tag_relations
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy



## room_tag_relations

| column       | 型          | option            |
| ------------ | ----------- | ----------------- |
| room         | references  | foreign_key: true |
| tag          | references  | foreign_key: true |

### association

- belongs_to :room
- belongs_to :tag


## tags

| column       | 型          | option                        |
| ------------ | ----------- | ----------------------------- |
| name         | string      | null: false, uniqueness: true |

### association

- has_many :rooms, through: :room_tag_relations
- has_many :room_tag_relations


## comments 

| column       | 型          | option            |
| ------------ | ----------- | ----------------- |
| text         | string      | null: false       |
| user         | references  | foreign_key: true |
| room         | references  | foreign_key: true |

### association

- belongs_to :user
- belongs_to :room

## likes 

| column       | 型          | option            |
| ------------ | ----------- | ----------------- |
| user         | references  | foreign_key: true |
| room         | references  | foreign_key: true |

- belongs_to :user
- belongs_to :room



