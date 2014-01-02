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

ActiveRecord::Schema.define(version: 20140102185605) do

  create_table "admins", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", force: true do |t|
    t.integer  "member_id"
    t.integer  "opening_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
  end

  add_index "applications", ["member_id"], name: "index_applications_on_member_id", using: :btree
  add_index "applications", ["opening_id"], name: "index_applications_on_opening_id", using: :btree

  create_table "categorizations", force: true do |t|
    t.integer  "interest_id"
    t.integer  "opening_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categorizations", ["interest_id", "opening_id"], name: "index_categorizations_on_interest_id_and_opening_id", using: :btree
  add_index "categorizations", ["interest_id"], name: "index_categorizations_on_interest_id", using: :btree
  add_index "categorizations", ["opening_id"], name: "index_categorizations_on_opening_id", using: :btree

  create_table "employers", force: true do |t|
    t.string   "company",        limit: 50
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "skip",                      default: false
    t.integer  "openings_count",            default: 0
    t.string   "city",           limit: 30
    t.string   "state",          limit: 30
    t.string   "zip_code",       limit: 10
  end

  add_index "employers", ["openings_count"], name: "index_employers_on_openings_count", using: :btree

  create_table "favoriteds", force: true do |t|
    t.integer  "employer_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favoriteds", ["member_id", "employer_id"], name: "index_favoriteds_on_member_id_and_employer_id", using: :btree
  add_index "favoriteds", ["member_id"], name: "index_favoriteds_on_member_id", using: :btree

  create_table "interesteds", force: true do |t|
    t.integer  "interest_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interesteds", ["interest_id"], name: "index_interesteds_on_interest_id", using: :btree
  add_index "interesteds", ["member_id", "interest_id"], name: "index_interesteds_on_member_id_and_interest_id", using: :btree
  add_index "interesteds", ["member_id"], name: "index_interesteds_on_member_id", using: :btree

  create_table "interests", force: true do |t|
    t.string   "name",           limit: 35
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "openings_count",            default: 0
    t.integer  "members_count",             default: 0
  end

  add_index "interests", ["members_count"], name: "index_interests_on_members_count", using: :btree
  add_index "interests", ["openings_count"], name: "index_interests_on_openings_count", using: :btree

  create_table "members", force: true do |t|
    t.string   "first_name",           limit: 25
    t.string   "last_name",            limit: 25
    t.string   "address_1",            limit: 50
    t.string   "address_2",            limit: 50
    t.string   "city",                 limit: 30
    t.string   "state",                limit: 30
    t.string   "zip_code",             limit: 10
    t.string   "phone",                limit: 25
    t.text     "volunteer_experience"
    t.text     "work_experience"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "skip",                            default: false
  end

  create_table "openings", force: true do |t|
    t.integer  "employer_id"
    t.string   "position"
    t.text     "description"
    t.boolean  "active"
    t.date     "date_open"
    t.date     "date_closed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "views_count",            default: 0
    t.string   "city",        limit: 30
    t.string   "state",       limit: 30
    t.string   "zip_code",    limit: 10
  end

  add_index "openings", ["employer_id"], name: "index_openings_on_employer_id", using: :btree
  add_index "openings", ["views_count"], name: "index_openings_on_views_count", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  limit: 100
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "role_type",                          default: "Member", null: false
    t.integer  "role_id",                                               null: false
    t.boolean  "force_reset",                        default: false
    t.integer  "def_table_disp",                     default: 10
  end

  add_index "users", ["role_type", "role_id"], name: "index_users_on_role_id", unique: true, using: :btree
  add_index "users", ["role_type"], name: "index_users_on_role_type", using: :btree

end
