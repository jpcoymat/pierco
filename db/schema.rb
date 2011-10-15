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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111015034713) do

  create_table "companies", :force => true do |t|
    t.string   "name",                   :limit => 100,                                :null => false
    t.string   "address_1",              :limit => 100,                                :null => false
    t.string   "address_2"
    t.string   "city",                   :limit => 100,                                :null => false
    t.string   "state",                  :limit => 50,                                 :null => false
    t.string   "postal_code",            :limit => 10,                                 :null => false
    t.string   "country",                :limit => 100,                                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_filename",         :limit => 100
    t.text     "about_us"
    t.string   "telephone_1",            :limit => 20
    t.string   "telephone_2",            :limit => 20
    t.string   "telephone_3",            :limit => 20
    t.string   "telephone_4",            :limit => 20
    t.string   "telephone_5",            :limit => 20
    t.string   "fax",                    :limit => 20
    t.string   "email",                  :limit => 50
    t.decimal  "latitude",                              :precision => 10, :scale => 5
    t.decimal  "longitude",                             :precision => 10, :scale => 5
    t.integer  "default_distributor_id"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "company_id",               :null => false
    t.string   "name",       :limit => 75, :null => false
    t.string   "email",      :limit => 75, :null => false
    t.text     "message",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distributors", :force => true do |t|
    t.integer  "company_id",                                                :null => false
    t.string   "name",        :limit => 100,                                :null => false
    t.string   "address_1",   :limit => 100,                                :null => false
    t.string   "address_2",   :limit => 100
    t.string   "city",        :limit => 100,                                :null => false
    t.string   "state",       :limit => 100
    t.string   "postal_code", :limit => 10
    t.string   "country",     :limit => 50,                                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "telephone_1", :limit => 15
    t.string   "telephone_2", :limit => 15
    t.string   "telephone_3", :limit => 15
    t.string   "email",       :limit => 50
    t.decimal  "latitude",                   :precision => 10, :scale => 5
    t.decimal  "longitude",                  :precision => 10, :scale => 5
  end

  create_table "product_categories", :force => true do |t|
    t.integer  "company_id",                                         :null => false
    t.string   "name",             :limit => 50,                     :null => false
    t.string   "description",      :limit => 100,                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "length",                          :default => false
    t.boolean  "width",                           :default => false
    t.boolean  "maximum_pressure",                :default => false
    t.boolean  "maximum_weight",                  :default => false
    t.boolean  "color",                           :default => false
    t.boolean  "diameter",                        :default => false
  end

  create_table "product_dimensions", :force => true do |t|
    t.integer  "product_id"
    t.string   "name",                                                          :null => false
    t.decimal  "length",                         :precision => 10, :scale => 2
    t.decimal  "width",                          :precision => 10, :scale => 2
    t.decimal  "maximum_pressure",               :precision => 10, :scale => 2
    t.decimal  "maximum_weight",                 :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color",            :limit => 25
    t.decimal  "diameter",                       :precision => 10, :scale => 2
  end

  create_table "product_subcategories", :force => true do |t|
    t.integer  "product_category_id",                :null => false
    t.string   "name",                :limit => 50,  :null => false
    t.string   "description",         :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.integer  "supplier_id",                                            :null => false
    t.string   "name",                   :limit => 50,                   :null => false
    t.boolean  "active",                               :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_filename",         :limit => 50
    t.integer  "product_category_id"
    t.integer  "product_subcategory_id"
    t.text     "description"
  end

  create_table "supplier_contacts", :force => true do |t|
    t.integer  "supplier_id",               :null => false
    t.string   "first_name",  :limit => 50, :null => false
    t.string   "last_name",   :limit => 50, :null => false
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

  create_table "suppliers", :force => true do |t|
    t.string   "name",           :limit => 100, :null => false
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.integer  "company_id",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website",        :limit => 100
    t.string   "image_filename", :limit => 50
    t.string   "telephone",      :limit => 20
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",      :limit => 50, :null => false
    t.string   "last_name",       :limit => 50, :null => false
    t.string   "hashed_password",               :null => false
    t.string   "username",        :limit => 25, :null => false
    t.string   "email",           :limit => 50
    t.integer  "company_id",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
