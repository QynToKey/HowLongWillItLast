# ER Diagram

## 1️⃣ エンティティ一覧

- users
- learning_themes
- learning_records
- todos

---

## 2️⃣ エンティティ責務整理

### users

- アプリ利用者
- 認証情報を持つ

### learning_themes

- ユーザーが設定する学習テーマ
- 1ユーザーに属する

### learning_records

- 日々の学習記録
- 1テーマに属する

### todos

- テーマ単位のタスク
- 1テーマに属する

---

## 3️⃣ リレーション整理

- `user` は 0以上の `learning_themes`を持つ
- `learning_theme` は 0以上の `learning_records` を持つ
- `learning_theme` は 0以上の `todos` を持つ
- 多対多関係は存在しない

---

## 4️⃣ 設計判断メモ

- `learning_records`に `user_id` は持たせない
  - `learning_theme` を経由して `user` に帰属するため
  - 冗長性 および 整合性リスク を回避する

  👉 *ユーザーが `learning_theme` を削除した場合、そこに紐づいた一連の長期記録も消えるが、その判断をユーザーに委ねることが本アプリの設計思想の根幹である「内省」を促すと考えた*

---

## 5️⃣ 制約設計

- **NOT NULL** 制約
  - `users.email` は NOT NULL
  - `learning_themes.user_id`は NOT NULL
  - `learning_records.learning_theme_id` は NOT NULL
  - `todos.learning_theme_id` は NOT NULL
  - `learning_records.content` は NOT NULL (要検討)
  - `learning_records.duration_minutes` は NULL 許可

  👉 *`learning_records.duration_minutes` については本アプリの主たる機能に関するが、ユーザー判断で使わないことも敢えて許容したい*

- **UNIQUE** 制約
  - `users.email` は UNIQUE
  - `learning_themes.name` は *`user_id` + `name`* において UNIQUE

- **外部キー** 制約
  - `learning_themes.user_id` → `users.id`
  - `learning_records.learning_theme_id` → `learning_themes.id`
  - `todos.learning_theme_id`→ `learning_themes.id`

  削除ポリシー:
  - `learning_theme` 削除時に `learning_records` / `todos` は削除される
    - Rails: `dependent: :destroy`
    - DB: `ON DELETE CASCADE`
