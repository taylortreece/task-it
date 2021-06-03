# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_03_200632) do

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "industry"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "phone_number"
    t.string "email"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "subject_id"
    t.string "subject_title"
    t.string "subject_class"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.integer "conversation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "team_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "assigned_user_id"
    t.index ["team_id"], name: "index_positions_on_team_id"
    t.index ["user_id"], name: "index_positions_on_user_id"
  end

  create_table "project_comments", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.integer "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_comments_on_project_id"
    t.index ["user_id"], name: "index_project_comments_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.datetime "deadline"
    t.string "description"
    t.integer "company_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "completed", default: false
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "segment_comments", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.integer "segment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["segment_id"], name: "index_segment_comments_on_segment_id"
    t.index ["user_id"], name: "index_segment_comments_on_user_id"
  end

  create_table "segments", force: :cascade do |t|
    t.string "title"
    t.datetime "deadline"
    t.string "description"
    t.integer "project_id"
    t.integer "team_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "completed", default: false
    t.index ["project_id"], name: "index_segments_on_project_id"
    t.index ["team_id"], name: "index_segments_on_team_id"
    t.index ["user_id"], name: "index_segments_on_user_id"
  end

  create_table "task_comments", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.integer "task_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["task_id"], name: "index_task_comments_on_task_id"
    t.index ["user_id"], name: "index_task_comments_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.datetime "deadline"
    t.string "description"
    t.integer "segment_id"
    t.integer "position_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "assigned_user_id"
    t.boolean "completed", default: false
    t.index ["position_id"], name: "index_tasks_on_position_id"
    t.index ["segment_id"], name: "index_tasks_on_segment_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "company_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_teams_on_company_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "privilege", default: "Admin"
    t.integer "user_id"
    t.integer "assigned_position_id"
  end

end
