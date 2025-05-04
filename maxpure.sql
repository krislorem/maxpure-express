-- 用户表 t_user
CREATE TABLE t_user (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '唯一id',
  `name` VARCHAR(16) UNIQUE NOT NULL COMMENT '唯一用户名，1-16位',
  avatar VARCHAR(255) DEFAULT 'https://zjp01.oss-cn-beijing.aliyuncs.com/maxpure/sys-default/defaultHeader.jpeg' COMMENT '头像图片url, ',
  email VARCHAR(64) UNIQUE COMMENT '邮箱',
  phone VARCHAR(20) UNIQUE COMMENT '手机',
  `password` VARCHAR(255) NOT NULL COMMENT 'Argon2 Base64哈希值',
  wx VARCHAR(64) UNIQUE COMMENT '微信 uuid',
  github VARCHAR(64) UNIQUE COMMENT 'GitHub uuid',
  nickname VARCHAR(32) COMMENT '昵称',
  tag JSON COMMENT '标签数组，如 ["编程", "设计"]',
  chat VARCHAR(255) COMMENT '被关注时自动发送的回复内容',
  company VARCHAR(64) COMMENT '公司',
  domain VARCHAR(64) COMMENT '从事领域',
  location VARCHAR(64) COMMENT '定位',
  birth DATE COMMENT '生日 yyyy-mm-dd',
  remark VARCHAR(128)	COMMENT '简介 0-128位',
  gender ENUM('male', 'female', 'unknown') DEFAULT 'unknown' COMMENT '性别',
  link JSON COMMENT '个人链接，如 [{"name":"博客", "url":"https://xxx"}]',
  readme TEXT COMMENT '说明',
  country VARCHAR(255) COMMENT '地区',
  state TINYINT DEFAULT 0 COMMENT '0 正常，1 封禁',
  badge JSON COMMENT '徽章id数组，如 [1, 3]',
  fan_count INT DEFAULT 0 COMMENT '粉丝数',
  follow_count INT DEFAULT 0 COMMENT '关注数',
  like_count INT DEFAULT 0 COMMENT '被点赞数',
  user_level TINYINT DEFAULT 0 COMMENT '等级',
  exp INT DEFAULT 0 COMMENT '经验',
  coin INT DEFAULT 0 COMMENT '积分币数',
  pin JSON COMMENT '首页展示的笔记本id数组，[1,...]',
  book_count INT DEFAULT 0 COMMENT '笔记本数',
  note_count INT DEFAULT 0 COMMENT '笔记数',
  memo_count INT DEFAULT 0 COMMENT '日程小记数',
  talk_count INT DEFAULT 0 COMMENT '被评论数',
  read_count INT DEFAULT 0 COMMENT '被浏览数',
  mark_count INT DEFAULT 0 COMMENT '被精选数',
  word_count INT DEFAULT 0 COMMENT '总字数',
  `online` TINYINT DEFAULT 1 COMMENT '0 在线，1 离线',
  cover VARCHAR(255) COMMENT '主页封面url',
  theme ENUM('dark', 'light') DEFAULT 'light' COMMENT '主题',
  `language` ENUM('zh-CHS', 'en', 'zh-CHT', 'fr', 'de', 'ru', 'es', 'ar', 'ko', 'ja', "it") DEFAULT 'zh-CHS' COMMENT '语言',
  notify_reddot TINYINT DEFAULT 1 COMMENT '红点提醒 0 否，1 是',
  follow_notify TINYINT DEFAULT 0 COMMENT '关注通知 0客户端，1客户端+邮箱，2关闭',
  like_notify TINYINT DEFAULT 0 COMMENT '点赞通知 0客户端，1客户端+邮箱，2关闭',
  talk_notify TINYINT DEFAULT 0 COMMENT '评论通知 0客户端，1客户端+邮箱，2关闭',
  handle_notify TINYINT DEFAULT 0 COMMENT '待处理通知 0客户端，1客户端+邮箱，2关闭',
  sys_notify TINYINT DEFAULT 0 COMMENT '系统通知 0客户端，1客户端+邮箱，2关闭',
  other_notify TINYINT DEFAULT 0 COMMENT '其他通知 0客户端，1客户端+邮箱，2关闭',
  push_notify TINYINT DEFAULT 0 COMMENT '推送通知 0客户端，1客户端+邮箱，2关闭',
  ai_disabled TINYINT DEFAULT 0 COMMENT '0 启用AI，1 关闭AI',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  deleted TINYINT DEFAULT 0 COMMENT '0 未删，1 已删'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 笔记本表 t_book
CREATE TABLE t_book (
  id INT PRIMARY KEY AUTO_INCREMENT COMMENT '文件id',
  user_id INT NOT NULL COMMENT '用户id',
  `name` VARCHAR(64) NOT NULL COMMENT '文件名',
  type TINYINT COMMENT '0 markdown/txt，1 excel，2 pdf，3 epub，4 word，5 视频',
  content TEXT COMMENT '文件内容',
  tag JSON COMMENT '标签数组',
  cover VARCHAR(255) COMMENT '封面url',
  anchor JSON COMMENT '锚点数组，如 ["section1", "image2"]',
  state TINYINT DEFAULT 0 COMMENT '0 公开，1 私密',
  word_count INT DEFAULT 0 COMMENT '总字数',
  is_marked TINYINT DEFAULT 0 COMMENT '是否精选 0否，1是',
  like_count INT DEFAULT 0 COMMENT '点赞数',
  collect_count INT DEFAULT 0 COMMENT '收藏数',
  talk_count INT DEFAULT 0 COMMENT '评论数',
  read_count INT DEFAULT 0 COMMENT '浏览数',
  root_id INT DEFAULT 0 COMMENT '根文件id',
  parent_id INT DEFAULT 0 COMMENT '父文件id',
  child_count INT DEFAULT 0 COMMENT '子节点数',
  left_id INT DEFAULT 0 COMMENT '最左子节点id',
  right_id INT DEFAULT 0 COMMENT '最右子节点id',
  prev_id INT DEFAULT 0 COMMENT '前兄弟节点id',
  next_id INT DEFAULT 0 COMMENT '后兄弟节点id',
  edit_count INT DEFAULT 0 COMMENT '修改次数',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_deleted TINYINT DEFAULT 0 COMMENT '0 未删除，1 回收站',
  FOREIGN KEY (user_id) REFERENCES t_user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 评论表 t_comment
CREATE TABLE t_comment (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  avatar VARCHAR(255),
  location VARCHAR(64),
  content TEXT NOT NULL,
  anchor JSON,
  state TINYINT DEFAULT 0,
  word_count INT DEFAULT 0,
  is_marked TINYINT DEFAULT 0,
  like_count INT DEFAULT 0,
  talk_count INT DEFAULT 0,
  root_id INT DEFAULT 0,
  parent_id INT DEFAULT 0,
  child_count INT DEFAULT 0,
  left_id INT DEFAULT 0,
  right_id INT DEFAULT 0,
  prev_id INT DEFAULT 0,
  next_id INT DEFAULT 0,
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  is_deleted TINYINT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES t_user(id)
);

-- 小记表 t_memo
CREATE TABLE t_memo (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  location VARCHAR(64),
  `name` VARCHAR(64) NOT NULL,
  content TEXT,
  tag JSON,
  cover VARCHAR(255),
  anchor JSON,
  word_count INT DEFAULT 0,
  edit_count INT DEFAULT 0,
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_deleted TINYINT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES t_user(id)
);

-- 动作表 t_action
CREATE TABLE t_action (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  action_type TINYINT COMMENT '0 点赞，1 评论，2 收藏，3 回复，4 关注',
  object_type TINYINT COMMENT '0 笔记本，1 笔记，2 评论，3 用户',
  object_id INT NOT NULL,
	dest_id INT DEFAULT 0 COMMENT '0 表示不是收藏动作，收藏动作则是收藏夹id',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_deleted TINYINT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES t_user(id)
);

-- 私信表 t_chat
CREATE TABLE t_chat (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  chat_user_id INT NOT NULL COMMENT '私信对象id',
  avatar VARCHAR(255),
  content TEXT NOT NULL,
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME,
  is_deleted TINYINT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES t_user(id),
  FOREIGN KEY (chat_user_id) REFERENCES t_user(id)
);

-- 日志表 t_log
CREATE TABLE t_log (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  reqtype TINYINT COMMENT '0 登录，1 注册，2 修改密码，3 登出，4 文件上传',
  `status` TINYINT COMMENT '0 成功，1 失败',
	device VARCHAR(255),
  content TEXT,
  ip VARCHAR(45),
  location VARCHAR(64),
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  is_deleted TINYINT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES t_user(id)
);

-- 收藏夹表 t_collect
CREATE TABLE t_collect (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  `name` VARCHAR(32) NOT NULL COMMENT '收藏夹名，1-32位',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_deleted TINYINT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES t_user(id)
);

-- 消息表 t_message
CREATE TABLE t_message (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
	source_id INT NOT NULL COMMENT '来源用户id，0 是系统',
	source_avatar VARCHAR(255),
  type TINYINT COMMENT '0 系统广播，1 系统定向，2 收到点赞，3 收到评论，4 @我，5 新增粉丝，6 关注私信',
	title VARCHAR(64) NOT NULL,
	content TEXT NOT NULL,
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
	update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_deleted TINYINT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES t_user(id)
);

-- 模板表 t_template
CREATE TABLE t_template (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
	avatar VARCHAR(255),
  `name` VARCHAR(64) NOT NULL,
	intro VARCHAR(255) NOT NULL,
  content TEXT,
  word_count INT DEFAULT 0,
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_deleted TINYINT DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES t_user(id)
);
