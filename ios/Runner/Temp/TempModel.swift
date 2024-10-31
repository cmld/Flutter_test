//
//  TempModel.swift
//  Runner
//
//  Created by yl on 2024/6/17.
//

import Foundation
import HandyJSON

struct JTStoreCertificationDetailModel: HandyJSON {

    var id: String = ""
    /// 建设类型 1-自建、2-合作
    var buildType: Int = -1
    /// 建设类型文字
    var buildTypeStr: String = ""
    /// 省
    var provinceDesc: String = ""
    /// 市
    var cityDesc: String = ""
    /// 区
    var areaDesc: String = ""
    /// 乡镇地址
    var townDesc: String = ""
    /// 详细地址
    var detailAddress: String = ""
    /// 门店联系人
    var contactUser: String = ""
    /// 门店联系方式
    var contactPhone: String = ""
    /// 行政区域 1-城区 2-乡镇 3-农村 4-学校
    var administrativeArea: Int = -1
    /// 行政区域文字
    var administrativeAreaStr: String = ""
    
//    var manageStatus: Int = -1
    
    
//    var manageStatusStr: String = ""
    /// 区域类型 1-学校 2-机关单位 3-商圈 4-其他类型
    var areaType: Int = -1
    /// 区域类型文字
    var areaTypeStr: String = ""
    /// 所属业务员编号
    var belongStaffCode: String = ""
    /// 所属业务员姓名
    var belongStaffName: String = ""
    /// 门店门头照片，多个用逗号分隔
    var headerPicture: String = ""
    var oriHeaderPicture: [String] = []
    var headerPictureList: [String] = []
    /// 门店室内照片，多个用逗号分隔
    var innerPicture: String = ""
    var oriInnerPicture: [String] = []
    var innerPictureList: [String] = []
    /// 备案信息照片，多个用逗号分隔
    var recordPicture: String = ""
    var oriRecordPicture: [String] = []
    var recordPictureList: [String] = []
    /// 证明材料，多个用逗号分隔
    var provePicture: String = ""
    var oriProvePicture: [String] = []
    var provePictureList: [String] = []
    /// 门店状态
    var status: Int = 0
    /// 认证时间
    var authTime: String = ""
    /// 清退时间
    var clearTime: String = ""
    /// 增值服务备注
    var otherServiceRemark: String = ""
    /// 各个快递公司信息备注
    var priceInfoRemark: String = ""
    /// 各个快递公司入库单价
    var companyPrice: String = ""
    /// 门店名称
    var courierStationName: String = ""
    /// 门店编码
    var courierStationCode: String = ""
    /// 门店注册时间
    var registerTime: String = ""
    /// 门店总面积
    var totalBuildArea: String = ""
    /// 门店面积
    var buildArea: String = ""
    /// 快递面积
    var expressArea: Int = 0
    /// 商业面积
    var buildBusinessArea: String = ""
    /// 门店营业开始时间
//    var businessStartTime: String = ""
    /// 门店营业结束时间
//    var businessEndTime: String = ""
    /// 是否备案 1是  2否
    var isRecord: String = ""
    /// 经营范围 1.快递  2.快递+商业
    var businessScope: Int = 0
    /// 经营范围文字
    var businessScopeStr: String = ""
    /// 门店品牌
    var businessName: String = ""
    /// 品牌id
    var businessId: String = ""
    /// 增值服务列表，入参为List，对应数字即可 "1","送货上门 " "2","门店寄件 " "3","商业 " "4","直链 " "5","春节不打烊 " "6","无"
    var otherServiceList: [Int] = []
    var otherServiceStr: String = ""
    /// 门店形象 1.形象  2非形像
    var imageStore: Int = 0
    
    var imageStoreStr: String = ""
    /// 省ID
    var provinceId: Int = 0
    /// 市ID
    var cityId: Int = 0
    /// 区ID
    var areaId: Int = 0
    /// 显示的省市区
    var showAddress: String  = ""
    
//    var upsUser: JTStoreCertificationDetailUserModel = JTStoreCertificationDetailUserModel()
    
    var statusStr: String = ""
    
    var auditor: String = ""
    
    var rejectReason: String = ""
    
    var applyTime: String = ""
    /// 寄件账户名称
    var sendAccountName: String = ""
    /// 寄件账户编号
    var sendAccountCode: String = ""
    /// 是否有寄件业务 1-是 2-否
    var sendService: Int = 0
    /// 是否提供驿站送货上门服务  1-是 2-否
    var homeDelivery: Int = 0
    /// 是否开通直送服务  1-是 2-否
    var directSend: Int = 0
    
//    var directSendStr: String {
//        switch directSend {
//        case 1:
//            return "是"
//        case 2:
//            return "否"
//        default:
//            return ""
//        }
//    }
    
}


struct JTStoreCertificationDetailUserModel: HandyJSON {
    
    var id: Int = 0
    
    var name: String = ""
    
    var staffNo: String = ""
    
    var networkId: Int = 0
    
    var networkName: String = ""
    
}
