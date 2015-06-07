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

ActiveRecord::Schema.define(version: 20150107230110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "change_logs", force: :cascade do |t|
    t.integer  "reference_object_id"
    t.string   "reference_object_type"
    t.string   "reference_attribute"
    t.string   "old_value"
    t.string   "new_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",                   limit: 100,                          null: false
    t.string   "address_1",              limit: 100,                          null: false
    t.string   "address_2"
    t.string   "city",                   limit: 100,                          null: false
    t.string   "state",                  limit: 50,                           null: false
    t.string   "postal_code",            limit: 10,                           null: false
    t.string   "country",                limit: 100,                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "about_us_main"
    t.string   "telephone_1",            limit: 20
    t.string   "telephone_2",            limit: 20
    t.string   "telephone_3",            limit: 20
    t.string   "telephone_4",            limit: 20
    t.string   "telephone_5",            limit: 20
    t.string   "fax",                    limit: 20
    t.string   "email",                  limit: 50
    t.decimal  "latitude",                           precision: 10, scale: 5
    t.decimal  "longitude",                          precision: 10, scale: 5
    t.integer  "default_distributor_id"
    t.string   "slogan",                 limit: 150
    t.text     "headline_1_content"
    t.text     "headline_2_content"
    t.text     "headline_3_content"
    t.string   "headline_1_title",       limit: 50
    t.string   "headline_2_title",       limit: 50
    t.string   "headline_3_title",       limit: 50
    t.string   "company_picture"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "company_id",            null: false
    t.string   "name",       limit: 75, null: false
    t.string   "email",      limit: 75, null: false
    t.text     "message",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distributors", force: :cascade do |t|
    t.integer  "company_id",                                       null: false
    t.string   "name",        limit: 100,                          null: false
    t.string   "address_1",   limit: 100,                          null: false
    t.string   "address_2",   limit: 100
    t.string   "city",        limit: 100,                          null: false
    t.string   "state",       limit: 100
    t.string   "postal_code", limit: 10
    t.string   "country",     limit: 50,                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "telephone_1", limit: 15
    t.string   "telephone_2", limit: 15
    t.string   "telephone_3", limit: 15
    t.string   "email",       limit: 50
    t.decimal  "latitude",                precision: 10, scale: 5
    t.decimal  "longitude",               precision: 10, scale: 5
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 100, null: false
    t.text     "content",                null: false
    t.integer  "company_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer  "company_id",                                      null: false
    t.string   "name",                limit: 50,                  null: false
    t.string   "description",         limit: 100,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "length",                          default: false
    t.boolean  "width",                           default: false
    t.boolean  "maximum_pressure",                default: false
    t.boolean  "maximum_weight",                  default: false
    t.boolean  "color",                           default: false
    t.boolean  "diameter",                        default: false
    t.boolean  "part_number",                     default: false
    t.boolean  "service_description",             default: false
    t.boolean  "lateral_wall",                    default: false
    t.boolean  "rim_width_range",                 default: false
    t.boolean  "tred_depth",                      default: false
    t.boolean  "offset",                          default: false
    t.boolean  "pcd",                             default: false
    t.boolean  "holes",                           default: false
    t.boolean  "x_factor",                        default: false
  end

  create_table "product_dimensions", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "name",                                                    null: false
    t.decimal  "length",                         precision: 10, scale: 2
    t.decimal  "width",                          precision: 10, scale: 2
    t.decimal  "maximum_pressure",               precision: 10, scale: 2
    t.decimal  "maximum_weight",                 precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color",               limit: 50
    t.decimal  "diameter",                       precision: 10, scale: 2
    t.string   "part_number",         limit: 75
    t.string   "service_description", limit: 20
    t.string   "lateral_wall",        limit: 20
    t.string   "rim_width_range",     limit: 20
    t.string   "tred_depth",          limit: 20
    t.string   "offset",              limit: 50
    t.string   "pcd",                 limit: 50
    t.string   "holes",               limit: 50
    t.string   "x_factor",            limit: 50
  end

  create_table "product_photos", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "product_photo"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "product_subcategories", force: :cascade do |t|
    t.integer  "product_category_id",                         null: false
    t.string   "name",                limit: 50,              null: false
    t.string   "description",         limit: 100,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_priority",                default: 0
  end

  create_table "products", force: :cascade do |t|
    t.integer  "supplier_id",                                      null: false
    t.string   "name",                   limit: 50,                null: false
    t.boolean  "active",                            default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_category_id"
    t.integer  "product_subcategory_id"
    t.text     "description"
    t.string   "product_picture"
  end

  create_table "supplier_contacts", force: :cascade do |t|
    t.integer  "supplier_id",            null: false
    t.string   "first_name",  limit: 50, null: false
    t.string   "last_name",   limit: 50, null: false
    t.string   "position"
    t.string   "telephone"
    t.string   "cell_phone"
    t.string   "email"
    t.string   "fax"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",             limit: 100, null: false
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.integer  "company_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website",          limit: 100
    t.string   "telephone",        limit: 20
    t.string   "supplier_picture"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 50, null: false
    t.string   "last_name",       limit: 50, null: false
    t.string   "hashed_password",            null: false
    t.string   "username",        limit: 25, null: false
    t.string   "email",           limit: 50
    t.integer  "company_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
