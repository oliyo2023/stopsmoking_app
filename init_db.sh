#!/bin/bash

# PocketBase 数据库初始化脚本

# 创建 plans 集合
pocketbase migrate create plans --sql="
CREATE TABLE plans (
    id TEXT PRIMARY KEY NOT NULL,
    user TEXT NOT NULL REFERENCES users(id),
    start_date DATETIME NOT NULL,
    initial_amount REAL NOT NULL,
    reduction_rate REAL NOT NULL
);
"

# 创建 progress 集合
pocketbase migrate create progress --sql="
CREATE TABLE progress (
    id TEXT PRIMARY KEY NOT NULL,
    user TEXT NOT NULL REFERENCES users(id),
    date DATETIME NOT NULL,
    cigarettes INTEGER NOT NULL
);
"

# 创建 articles 集合
pocketbase migrate create articles --sql="
CREATE TABLE articles (
    id TEXT PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    category TEXT NOT NULL
);
"

echo "数据库初始化完成。"

# 运行 Flutter Web 应用，强制使用 HTML 渲染器
flutter run -d chrome --web-renderer html