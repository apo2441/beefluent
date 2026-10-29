-- BeeFluent database schema
-- Import in phpMyAdmin, or: mysql -u root < database/schema.sql

CREATE DATABASE IF NOT EXISTS ai_tutor CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ai_tutor;

CREATE TABLE IF NOT EXISTS users (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  name           VARCHAR(100) NOT NULL,
  email          VARCHAR(150) NOT NULL UNIQUE,
  password_hash  VARCHAR(255) NOT NULL,
  language_level VARCHAR(30)  DEFAULT NULL,
  avatar_path    VARCHAR(255) DEFAULT NULL,
  role           VARCHAR(20)  NOT NULL DEFAULT 'user',
  reset_token    VARCHAR(255) DEFAULT NULL,
  reset_expires  DATETIME     DEFAULT NULL,
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS chats (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  user_id    INT NOT NULL,
  session_id VARCHAR(64) DEFAULT NULL,
  role       VARCHAR(20) NOT NULL,
  message    TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX (user_id), INDEX (session_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS test_results (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  user_id    INT NOT NULL,
  percentage DECIMAL(5,2) NOT NULL,
  level      VARCHAR(30) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS activity_log (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  admin_id       INT NOT NULL,
  action         VARCHAR(100) NOT NULL,
  target_user_id INT DEFAULT NULL,
  meta_json      TEXT,
  ip_address     VARCHAR(45),
  user_agent     VARCHAR(255),
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Demo admin. Email: admin@beefluent.local  Password: admin123 (change after first login)
INSERT INTO users (name, email, password_hash, role) VALUES
('Admin', 'admin@beefluent.local', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'admin');
