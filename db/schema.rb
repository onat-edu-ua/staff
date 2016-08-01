# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160801094225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_groups", force: :cascade do |t|
    t.string "name", null: false
    t.string "tag",  null: false
  end

  add_index "access_groups", ["name"], name: "access_groups_name_key", unique: true, using: :btree
  add_index "access_groups", ["tag"], name: "access_groups_tag_key", unique: true, using: :btree

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "departments", ["name"], name: "departments_name_key", unique: true, using: :btree

  create_table "email_domains", force: :cascade do |t|
    t.string "domain", null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string  "username",              null: false
    t.integer "domain_id",   limit: 2, null: false
    t.integer "employee_id"
    t.string  "password",              null: false
  end

  create_table "employee_positions", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "employee_positions", ["name"], name: "employee_positions_name_key", unique: true, using: :btree

  create_table "employees", force: :cascade do |t|
    t.string  "first_name",                 null: false
    t.string  "last_name",                  null: false
    t.string  "middle_name"
    t.integer "department_id",              null: false
    t.integer "access_group_ids",                        array: true
    t.string  "login",                      null: false
    t.string  "password",                   null: false
    t.integer "position_id",      limit: 2, null: false
  end

  add_index "employees", ["login"], name: "employees_login_key", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",                null: false
    t.integer  "item_id",                  null: false
    t.string   "event",                    null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
    t.integer  "txid",           limit: 8
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "emails", "email_domains", column: "domain_id", name: "emails_domain_id_fkey"
  add_foreign_key "emails", "employees", name: "emails_employee_id_fkey"
  add_foreign_key "employees", "departments", name: "employees_department_id_fkey"
  add_foreign_key "employees", "employee_positions", column: "position_id", name: "employees_position_id_fkey"
end
