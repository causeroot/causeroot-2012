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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121129053134) do

  create_table "causes", :force => true do |t|
    t.integer  "issue_id"
    t.text     "cause"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "effects", :force => true do |t|
    t.integer  "issue_id"
    t.text     "effect"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "game_results", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "answer"
    t.boolean  "same"
    t.boolean  "skip"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "game_results_issues", :force => true do |t|
    t.integer "issue_id"
    t.integer "game_result_id"
  end

  create_table "issues", :force => true do |t|
    t.text     "problem"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "name"
    t.string   "question"
    t.integer  "problem_count"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                        :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["last_logout_at", "last_activity_at"], :name => "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
