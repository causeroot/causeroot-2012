CREATE TABLE "challenges" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "url_id" integer, "description" text, "award" varchar(255), "deadline" datetime, "post_date" datetime, "image" varchar(255), "rules" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "rules" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "type" varchar(255), "xpath" varchar(255), "regex" varchar(255), "token" varchar(255), "modifier" varchar(255), "field_name" varchar(255), "scraper_id" integer, "rule_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "scrapers" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "url_id" integer, "site_id" integer, "rule_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "sites" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "url_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "urls" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "url" varchar(255), "rank" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "password_salt" varchar(255), "confirmation_token" varchar(255), "confirmed_at" datetime, "confirmation_sent_at" datetime, "unconfirmed_email" varchar(255), "failed_attempts" integer DEFAULT 0, "unlock_token" varchar(255), "locked_at" datetime, "authentication_token" varchar(255), "first_name" varchar(255), "last_name" varchar(255), "karma" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_users_on_authentication_token" ON "users" ("authentication_token");
CREATE UNIQUE INDEX "index_users_on_confirmation_token" ON "users" ("confirmation_token");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "index_users_on_unlock_token" ON "users" ("unlock_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20120427050747');

INSERT INTO schema_migrations (version) VALUES ('20120427052957');

INSERT INTO schema_migrations (version) VALUES ('20120502034756');

INSERT INTO schema_migrations (version) VALUES ('20120502040033');

INSERT INTO schema_migrations (version) VALUES ('20120523054324');

INSERT INTO schema_migrations (version) VALUES ('20120523055228');