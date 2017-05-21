-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2017-05-21 18:21:30
-- 服务器版本： 5.7.14
-- PHP Version: 7.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `accounting`
--

-- --------------------------------------------------------

--
-- 表的结构 `expenditure`
--

CREATE TABLE `expenditure` (
  `id` int(11) NOT NULL COMMENT '自增ID',
  `wid` int(11) NOT NULL COMMENT '所属账户ID',
  `detail` varchar(255) DEFAULT NULL COMMENT '支出详情说明',
  `money` int(11) NOT NULL COMMENT '支出金额',
  `time` int(11) NOT NULL COMMENT '支出时间',
  `tid` int(11) DEFAULT NULL COMMENT '标签ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金支出表';

-- --------------------------------------------------------

--
-- 表的结构 `income`
--

CREATE TABLE `income` (
  `id` int(11) NOT NULL COMMENT '自增ID',
  `wid` int(11) NOT NULL COMMENT '所属账户ID',
  `detail` varchar(255) DEFAULT NULL COMMENT '收入详情说明',
  `money` int(11) NOT NULL COMMENT '收入金额',
  `time` int(11) NOT NULL COMMENT '时间',
  `tid` int(11) DEFAULT NULL COMMENT '所属标签'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金收入表';

-- --------------------------------------------------------

--
-- 表的结构 `tag`
--

CREATE TABLE `tag` (
  `id` int(11) NOT NULL COMMENT '自增ID',
  `name` varchar(255) NOT NULL COMMENT '标签名称',
  `wid` varchar(255) NOT NULL COMMENT '所属账户ID',
  `sort` int(11) NOT NULL COMMENT '排序',
  `level` int(11) NOT NULL DEFAULT '1' COMMENT '标签级别（一级1，二级2...)',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `updatetime` int(11) NOT NULL COMMENT '最新操作时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='标签表';

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL COMMENT '自增ID',
  `name` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `mail` varchar(255) NOT NULL COMMENT '邮箱',
  `time` int(11) NOT NULL COMMENT '注册时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- --------------------------------------------------------

--
-- 表的结构 `wallet`
--

CREATE TABLE `wallet` (
  `id` int(11) NOT NULL COMMENT '自增ID',
  `name` varchar(255) NOT NULL COMMENT '账户名称',
  `money` int(11) NOT NULL COMMENT '账户余额',
  `uid` int(11) NOT NULL COMMENT '所属用户'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户资金账户表';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `expenditure`
--
ALTER TABLE `expenditure`
  ADD PRIMARY KEY (`id`),
  ADD KEY `所含资金账户` (`wid`),
  ADD KEY `tid` (`tid`);

--
-- Indexes for table `income`
--
ALTER TABLE `income`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tid` (`tid`),
  ADD KEY `wid` (`wid`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wid` (`wid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wallet`
--
ALTER TABLE `wallet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uid` (`uid`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `expenditure`
--
ALTER TABLE `expenditure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `income`
--
ALTER TABLE `income`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 使用表AUTO_INCREMENT `wallet`
--
ALTER TABLE `wallet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID';
--
-- 限制导出的表
--

--
-- 限制表 `tag`
--
ALTER TABLE `tag`
  ADD CONSTRAINT `tag_ibfk_1` FOREIGN KEY (`id`) REFERENCES `income` (`tid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tag_ibfk_2` FOREIGN KEY (`id`) REFERENCES `expenditure` (`tid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`id`) REFERENCES `wallet` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `wallet`
--
ALTER TABLE `wallet`
  ADD CONSTRAINT `wallet_ibfk_1` FOREIGN KEY (`id`) REFERENCES `income` (`wid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wallet_ibfk_2` FOREIGN KEY (`id`) REFERENCES `expenditure` (`wid`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
