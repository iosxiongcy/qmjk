//
//  Models.swift
//  PerfectDemo3
//
//  Created by 深圳前海全民健康科技股份有限公司 on 2017/8/4.
//
//  模型类

import Foundation

// MARK: - 用户模型
struct User {
    var userId: String?
    var desc: String?
    var email: String?
    var github: String?
    var qq: String?
}

// MARK: - 文章模型
struct Blog {
    var id: Int?
    var title: String?
    var description: String?
    var releaseTime: String?
    var text: String?
    var categoryid: String?
    var userid: String?
}

// MARK: - 分类模型
struct Category {
    var id: Int?
    var name: String?
}

// MARK: - 评论模型
struct Comment {
    var id: Int?
    var commentUserId: Int?
    var commentedUserId: Int?
    var name: String?
    var text: String?
    var createTime: String?
    var blogId: Int?
}
