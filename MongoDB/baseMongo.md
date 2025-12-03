根据您提供的文件内容，以下是一篇详细的“Mongo 快速上手”Markdown 文档。

# 📘 MongoDB 快速上手指南

本指南旨在帮助您快速理解 MongoDB 的核心概念、掌握单机部署方法以及常用的基本操作命令（CRUD、索引管理）。

## 1\. MongoDB 核心概念

### 1.1 简介

[cite_start]MongoDB 是一个开源、高性能、无模式（Schema-free）的文档型数据库 [cite: 733][cite_start]。它是 NoSQL 数据库产品中的一种，以其灵活的数据结构和易于扩展的特性而闻名 [cite: 733]。

  * [cite_start]**数据格式**: MongoDB 采用类似于 JSON 的 **BSON (Binary JSON)** 格式存储数据，它支持内嵌文档和数组对象，具有轻量性、可遍历性和高效性 [cite: 734, 767, 768, 769]。
  * [cite_start]**数据单位**: 最小存储单位是**文档 (Document)**，它对应于关系型数据库中的“行” [cite: 766]。

### 1.2 体系结构对比 (MySQL vs MongoDB)

| SQL 术语/概念 | MongoDB 术语/概念 | 解释/说明 |
| :------------ | :------------------ | :-------- |
| `database`    | `database`          | [cite_start]数据库 [cite: 764] |
| `table`       | `collection`        | [cite_start]数据库表/集合 [cite: 764] |
| `row`         | `document`          | [cite_start]数据记录行/文档 [cite: 764] |
| `column`      | `field`             | [cite_start]数据字段/域 [cite: 764] |
| `primary key` | `primary key` (`_id`) | [cite_start]主键，MongoDB 自动将 `_id` 字段设置为主键 [cite: 764] |
| `table joins` | (不支持)            | [cite_start]MongoDB 通过**嵌入文档**来替代多表连接 [cite: 764] |

### 1.3 业务应用场景

[cite_start]MongoDB 能够应对传统关系型数据库在“三高”需求面前的力不从心 [cite: 702, 707]。

**“三高”需求解释**:

  * [cite_start]**High Performance**: 对数据库高并发读写的需求 [cite: 704]。
  * [cite_start]**Huge Storage**: 对海量数据的高效率存储和访问的需求 [cite: 705]。
  * [cite_start]**High Scalability & High Availability**: 对数据库的高可扩展性和高可用性的需求 [cite: 706]。

**具体的应用场景包括**:

1.  [cite_start]**社交场景**: 存储用户信息，利用地理位置索引实现“附近的人”功能 [cite: 709]。
2.  [cite_start]**游戏场景**: 存储游戏用户信息、装备、积分等，以内嵌文档形式存储，方便查询 [cite: 710]。
3.  [cite_start]**物流场景**: 存储不断更新的订单状态，使用内嵌数组存储所有变更记录，一次查询即可读取 [cite: 711]。
4.  [cite_start]**物联网/视频直播**: 存储智能设备信息、设备日志、点赞互动信息等 [cite: 712, 713]。

### 1.4 主要特点

1.  [cite_start]**高性能**: 支持嵌入式数据模型、多种索引类型（文本、TTL、地理位置）以及 Gridfs 解决文件存储问题 [cite: 777, 779, 780, 782]。
2.  [cite_start]**高可用性**: 通过**副本集 (replica set)** 提供自动故障转移和数据冗余 [cite: 783, 784]。
3.  [cite_start]**高扩展性**: 通过**分片 (sharding)** 将数据分布在集群机器上，实现水平可扩展性 [cite: 785, 787]。
4.  [cite_start]**丰富的查询支持**: 支持 CRUD 操作、数据聚合、文本搜索和地理空间查询 [cite: 789, 790]。

## 2\. 单机部署

### 2.1 Windows 系统中的安装启动

1.  [cite_start]**下载安装包**: 从 [MongoDB 官网](https://www.mongodb.com/download-center#community) 下载预编译的 ZIP 包（以稳定版为准，如 `x.y.z` 中 `y` 为偶数） [cite: 795, 822]。
2.  [cite_start]**解压与目录创建**: 将压缩包解压，并在解压目录中手动创建数据存放目录，如 `data/db` [cite: 826, 827]。
3.  **启动服务 (方式一: 命令行参数)**:
    在 `bin` 目录中打开命令行，输入以下命令启动服务：
    ```bash
    mongod --dbpath=..\data\db
    ```
      * [cite_start]MongoDB 的默认端口是 **27017** [cite: 830, 831]。
4.  **启动服务 (方式二: 配置文件)**:
    在解压目录中新建 `config` 文件夹，创建配置文件 `mongod.conf`，并使用该文件启动：
    ```bash
    # mongod.conf 示例配置
    storage:
        dbPath: <你的数据目录路径> # 例如 D:\mongodb\data\db
    net:
        port: 27017
    # 启动命令
    mongod -f ../config/mongod.conf
    ```
      * [cite_start]注意：配置路径中如果使用 Windows 反斜杠 `\`，需要将其转换为 `/` 或 `\\` 以避免转义错误 [cite: 840, 843]。

### 2.2 Shell 连接与管理

在安装目录的 `bin` 目录中，可以使用 `mongo` 命令连接服务：

1.  **连接服务**:
    ```bash
    mongo
    # 或指定地址和端口
    mongo --host 127.0.0.1 --port 27017
    ```
      * [cite_start]MongoDB Shell 是一个基于 JavaScript 的解释器，支持 JS 程序 [cite: 867, 869, 877]。
2.  **查看数据库**:
    ```bash
    show dbs
    # 或
    show databases
    ```
      * [cite_start]默认数据库是 `test` [cite: 871, 1006]。
3.  **退出**:
    ```bash
    exit
    ```

### 2.3 Compass 图形化界面客户端

[cite_start]MongoDB Compass 是官方提供的图形化管理界面，可用于连接、查询和管理 MongoDB [cite: 878, 879]。

  * [cite_start]**使用方式**: 打开 Compass 界面，输入主机地址和端口（如 `localhost:27017`），点击连接即可 [cite: 882, 891]。

### 2.4 Linux 系统中的安装启动和连接 (单机部署)

1.  [cite_start]**准备环境**: 上传并解压压缩包，移动到指定目录，如 `/usr/local/mongodb` [cite: 897, 899, 901]。
2.  [cite_start]**创建目录**: 新建数据存储目录和日志存储目录 [cite: 903, 905]。
    ```bash
    mkdir -p /mongodb/single/data/db  # 数据存储目录
    mkdir -p /mongodb/single/log      # 日志存储目录
    ```
3.  [cite_start]**配置文件**: 创建并修改 `/mongodb/single/mongod.conf` 配置文件 [cite: 907]。
    ```yaml
    systemLog:
      destination: file
      [cite_start]path: "/mongodb/single/log/mongod.log" # 日志文件路径 [cite: 931]
      [cite_start]logAppend: true # 重启时附加到现有日志文件末尾 [cite: 933]
    storage:
      [cite_start]dbPath: "/mongodb/single/data/db" # 数据存储目录 [cite: 937]
      journal:
        [cite_start]enabled: true # 启用持久性日志 [cite: 939]
    processManagement:
      [cite_start]fork: true # 启用守护进程模式，后台运行 [cite: 941]
    net:
      [cite_start]bindIp: localhost, 192.168.0.2 # 绑定的 IP，默认 localhost [cite: 943]
      [cite_start]port: 27017 # 端口 [cite: 946]
    ```
4.  **启动服务**:
    ```bash
    /usr/local/mongodb/bin/mongod -f /mongodb/single/mongod.conf
    ```
      * [cite_start]启动成功会显示 `child process started successfully, parent exiting` [cite: 948, 951]。
5.  **停止服务 (标准关闭)**:
    [cite_start]标准关闭不易出错，通过客户端执行命令 [cite: 980, 981]。
    ```bash
    # 1. 客户端登录
    mongo --port 27017
    # 2. 切换到 admin 库
    use admin
    # 3. 关闭服务
    db.shutdownServer()
    ```

## 3\. 基本常用命令 (CRUD)

### 3.1 数据库操作

| 命令 | 描述 |
| :--- | :--- |
| `use articledb` | [cite_start]选择或创建数据库 `articledb` [cite: 997, 999] |
| `show dbs` | [cite_start]查看所有数据库 [cite: 1001] |
| `db` | [cite_start]查看当前正在使用的数据库 [cite: 1005] |
| `db.dropDatabase()` | [cite_start]删除当前正在使用的数据库 (删除已持久化的数据库) [cite: 1019, 1021] |

### 3.2 集合操作

| 命令 | 描述 |
| :--- | :--- |
| `db.createCollection("mycollection")` | [cite_start]显式创建一个集合（不常用） [cite: 1027, 1031] |
| `db.comment.insert({...})` | [cite_start]隐式创建集合：在首次插入文档时，如果集合不存在会自动创建 [cite: 1042] |
| `show collections` | [cite_start]查看当前数据库中的所有集合 [cite: 1033] |
| `db.comment.drop()` | [cite_start]删除 `comment` 集合 [cite: 1047, 1053] |

### 3.3 文档基本 CRUD

#### 3.3.1 插入文档 (Create)

**单个插入**:

```javascript
db.comment.insert({
    "articleid": "100000",
    "content": "今天天气真好,阳光明媚",
    "userid": "1001",
    "nickname": "Rose",
    "createdatetime": new Date(),  // 插入当前日期
    "likenum": NumberInt(10),      // 插入整型数字
    "state": null
})
```

  * [cite_start]**注意**: 默认数字类型是 `double`，整型需使用 `NumberInt(value)` 或 `NumberLong(value)` [cite: 1075, 774]。

**批量插入**:

```javascript
db.comment.insertMany([
    { "_id": "1", "content": "评论 1...", "userid": "1002" },
    { "_id": "2", "content": "评论 2...", "userid": "1005" }
])
```

#### 3.3.2 查询文档 (Retrieve)

| 命令 | 描述 | 示例 |
| :--- | :--- | :--- |
| `db.collection.find()` | 查询所有文档 | [cite_start]`db.comment.find()` [cite: 617] |
| `db.collection.find({<query>})` | 按条件查询 | [cite_start]`db.comment.find({userid:"1003"})` [cite: 617] |
| `db.collection.findOne({<query>})` | 返回符合条件的第一条记录 | [cite_start]`db.comment.findOne({userid:"1003"})` [cite: 617] |
| `db.collection.find({}, {<projection>})` | **投影查询**：返回部分字段 | [cite_start]`db.comment.find({}, {content: 1, _id: 0})` (只显示 content 字段，不显示 \_id) [cite: 617] |
| `db.collection.find().limit(N)` | 限制返回条数 | [cite_start]`db.comment.find().limit(2)` [cite: 627] |
| `db.collection.find().skip(N)` | 跳过指定条数 | [cite_start]`db.comment.find().skip(2)` [cite: 627] |
| `db.collection.find().sort({<field>:-1})` | 排序 (1:升序, -1:降序) | [cite_start]`db.comment.find().sort({createdatetime:-1})` [cite: 627, 629] |
| `db.collection.count({<query>})` | 统计记录数 | [cite_start]`db.comment.count({userid:"1003"})` [cite: 627] |

#### 3.3.3 修改文档 (Update)

**局部修改 (推荐)**：使用 `$set` 操作符更新指定字段，保留其他字段。

```javascript
// 修改 _id 为 2 的记录，将 likenum 设置为 889
db.comment.update({_id:"2"}, {$set: {likenum: NumberInt(889)}})
```

**批量修改**: 添加 `{multi:true}` 选项。

```javascript
// 修改所有 userid 为 1003 的用户的昵称
db.comment.update(
    {userid:"1003"},
    {$set:{nickname:"凯撒大帝"}},
    {multi:true}
)
```

**列值增长**: 使用 `$inc` 操作符实现字段值的自增或自减。

```javascript
// 对 _id 为 3 的记录，点赞数递增 1
db.comment.update({_id:"3"}, {$inc:{likenum: NumberInt(1)}})
```

#### 3.3.4 删除文档 (Delete)

```javascript
// 删除 _id 为 1 的记录
db.comment.remove({_id:"1"})
// 删除所有文档（请慎用）
db.comment.remove({})
```

### 3.4 常用命令小结

| 描述 | 命令示例 |
| :--- | :--- |
| 选择切换数据库 | [cite_start]`use articledb` [cite: 633] |
| 插入数据 | [cite_start]`db.comment.insert({bson数据})` [cite: 633] |
| 查询所有数据 | [cite_start]`db.comment.find()` [cite: 633] |
| 条件查询 | [cite_start]`db.comment.find({条件})` [cite: 634] |
| 模糊查询 | [cite_start]`db.comment.find({字段名:/正则表达式/})` [cite: 634] |
| 包含查询 | [cite_start]`db.comment.find({字段名:{$in:[值1, 值2]}})` [cite: 634] |
| 逻辑与/或查询 | [cite_start]`db.comment.find({$and:[{条件1},{条件2}]})` [cite: 634] |
| 局部修改 | [cite_start]`db.comment.update({条件}, {$set:{要修改的字段:数据}})` [cite: 634] |
| 列值自增 | [cite_start]`db.comment.update({条件}, {$inc:{自增的字段:步进值}})` [cite: 634] |
| 删除数据 | [cite_start]`db.comment.remove({条件})` [cite: 634] |

## 4\. 索引 (Index)

### 4.1 概述

[cite_start]索引是特殊的数据结构，支持在 MongoDB 中高效地执行查询 [cite: 633][cite_start]。没有索引时，MongoDB 必须执行**全集合扫描 (COLLSCAN)**，这在处理大量数据时效率非常低 [cite: 633]。

### 4.2 索引的类型

1.  [cite_start]**单字段索引 (Single Field Index)**: 在文档的单个字段上创建，升序 (`1`) 或降序 (`-1`) [cite: 633]。
      * [cite_start]*示例*: `db.comment.createIndex({userid: 1})` [cite: 645]。
2.  [cite_start]**复合索引 (Compound Index)**: 在多个字段上创建，字段顺序具有重要意义 [cite: 633]。
      * [cite_start]*示例*: `db.comment.createIndex({userid: 1, score: -1})` (先按 `userid` 正序，再在每个 `userid` 内按 `score` 倒序) [cite: 633]。
3.  [cite_start]**其他索引**: 地理空间索引 (Geospatial Index)、文本索引 (Text Indexes)、哈希索引 (Hashed Indexes) 等 [cite: 634]。

### 4.3 索引的管理操作

| 命令 | 描述 | 示例 |
| :--- | :--- | :--- |
| `db.collection.createIndex({<spec>})` | 创建索引 | [cite_start]`db.comment.createIndex({userid: 1})` [cite: 642] |
| `db.collection.getIndexes()` | 查看集合中所有索引 | [cite_start]`db.comment.getIndexes()` [cite: 641] |
| `db.collection.dropIndex(index)` | 移除指定的索引 | [cite_start]`db.comment.dropIndex({userid: 1})` [cite: 643] |
| `db.collection.dropIndexes()` | 移除所有非 `_id` 字段的索引 | [cite_start]`db.comment.dropIndexes()` [cite: 644] |

### 4.4 索引的使用 (执行计划)

[cite_start]通过查看**执行计划 (Explain Plan)** 可以分析查询性能、耗费时间以及是否使用了索引 [cite: 644]。

**语法**:

```javascript
db.collection.find(query,options).explain(options)
```

**关键点**:

  * [cite_start]`"stage" : "COLLSCAN"`: 表示查询进行了**全集合扫描**，效率低 [cite: 644]。
  * [cite_start]`"stage" : "IXSCAN"`: 表示查询是**基于索引的扫描**，效率高 [cite: 645]。

*示例: 查看根据 `userid` 查询数据的情况:*

```javascript
db.comment.find({userid:"1003"}).explain()
```