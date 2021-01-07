import 'dart:convert';

NotificationList notificationListFromJson(String str) => NotificationList.fromJson(json.decode(str));

String notificationListToJson(NotificationList data) => json.encode(data.toJson());

class NotificationList {
  NotificationList({
    this.status,
    this.message,
    this.data,
    this.recordsPerPage,
    this.page,
    this.total,
  });

  bool status;
  String message;
  List<Datum> data;
  int recordsPerPage;
  String page;
  int total;

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    recordsPerPage: json["records_per_page"],
    page: json["page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "records_per_page": recordsPerPage,
    "page": page,
    "total": total,
  };
}

class Datum {
  Datum({
    this.id,
    this.receiverId,
    this.senderId,
    this.storeId,
    this.checkinId,
    this.notificationFor,
    this.notificationType,
    this.notificationTitle,
    this.notificationDescription,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.storeName,
    this.checkinQrCode,
    this.checkoutQrCode,
    this.checkIn,
    this.checkOut,
    this.userId,
  });

  String id;
  ErId receiverId;
  ErId senderId;
  StoreId storeId;
  CheckinId checkinId;
  NotificationFor notificationFor;
  NotificationType notificationType;
  NotificationTitle notificationTitle;
  String notificationDescription;
  IsRead isRead;
  DateTime createdAt;
  dynamic updatedAt;
  StoreName storeName;
  String checkinQrCode;
  String checkoutQrCode;
  CheckIn checkIn;
  dynamic checkOut;
  dynamic userId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    receiverId: erIdValues.map[json["receiver_id"]],
    senderId: erIdValues.map[json["sender_id"]],
    storeId: storeIdValues.map[json["store_id"]],
    checkinId: checkinIdValues.map[json["checkin_id"]],
    notificationFor: notificationForValues.map[json["notification_for"]],
    notificationType: notificationTypeValues.map[json["notification_type"]],
    notificationTitle: notificationTitleValues.map[json["notification_title"]],
    notificationDescription: json["notification_description"],
    isRead: isReadValues.map[json["is_read"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    storeName: storeNameValues.map[json["store_name"]],
    checkinQrCode: json["checkin_qr_code"],
    checkoutQrCode: json["checkout_qr_code"],
    checkIn: checkInValues.map[json["check_in"]],
    checkOut: json["check_out"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "receiver_id": erIdValues.reverse[receiverId],
    "sender_id": erIdValues.reverse[senderId],
    "store_id": storeIdValues.reverse[storeId],
    "checkin_id": checkinIdValues.reverse[checkinId],
    "notification_for": notificationForValues.reverse[notificationFor],
    "notification_type": notificationTypeValues.reverse[notificationType],
    "notification_title": notificationTitleValues.reverse[notificationTitle],
    "notification_description": notificationDescription,
    "is_read": isReadValues.reverse[isRead],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
    "store_name": storeNameValues.reverse[storeName],
    "checkin_qr_code": checkinQrCode,
    "checkout_qr_code": checkoutQrCode,
    "check_in": checkInValues.reverse[checkIn],
    "check_out": checkOut,
    "user_id": userId,
  };
}

enum CheckIn { J_LBR_Y_Y_BX_CX_RS4_SAKC_T30_P423_DK_ML6_KXS_Z_PON_U, Q3_X_WIMUHW_RMX7_KJF_RJ_R_BI_HU_SZV7_WM_VKB_XXRQYJB_M8_L8, L_DJFZSN_K4_WN_RRHZCF_DD3_R_VWO_E_OSV_CG_MO07_QI_H_UC_A4 }

final checkInValues = EnumValues({
  "/j/lbrY//yBxCxRS4sakcT30p423dkML6+KxsZPon/U=": CheckIn.J_LBR_Y_Y_BX_CX_RS4_SAKC_T30_P423_DK_ML6_KXS_Z_PON_U,
  "LDjfzsnK4WNRrhzcfDd3rVwoEOsv/cgMO07/QiHUcA4=": CheckIn.L_DJFZSN_K4_WN_RRHZCF_DD3_R_VWO_E_OSV_CG_MO07_QI_H_UC_A4,
  "q3xWimuhwRMX7kjfRjRBiHuSZV7WMVkbXxrqyjbM8L8=": CheckIn.Q3_X_WIMUHW_RMX7_KJF_RJ_R_BI_HU_SZV7_WM_VKB_XXRQYJB_M8_L8
});

enum CheckinId { UHL3_K1_N4_ALF8_EGPRW03_F_IG, T_VXEK9_OE2_ORS40_YNCY_UE_IG, G_RJZ_BE_HB_XRCWAXXRD3_NK7_W }

final checkinIdValues = EnumValues({
  "GRjzBEHbXrcwaxxrd3nk7w==": CheckinId.G_RJZ_BE_HB_XRCWAXXRD3_NK7_W,
  "tVxek9OE2ors40yncyUeIg==": CheckinId.T_VXEK9_OE2_ORS40_YNCY_UE_IG,
  "UHL3k1n4Alf8EGPRW03fIg==": CheckinId.UHL3_K1_N4_ALF8_EGPRW03_F_IG
});

enum IsRead { DJV1_F_DF_JN9_N3_CA_OU_A_VHOK_Q }

final isReadValues = EnumValues({
  "DJV1fDfJN9n3CAOuAVhokQ==": IsRead.DJV1_F_DF_JN9_N3_CA_OU_A_VHOK_Q
});

enum NotificationFor { FVE_FXN9_PZZKT_LMQ016_LP_JW }

final notificationForValues = EnumValues({
  "fveFXN9PZZKTLmq016LpJw==": NotificationFor.FVE_FXN9_PZZKT_LMQ016_LP_JW
});

enum NotificationTitle { JVML4_V_TT6_V7_VM_AH_GJ_W_TW_QG }

final notificationTitleValues = EnumValues({
  "Jvml4vTT6V7vmAHGjWTwQg==": NotificationTitle.JVML4_V_TT6_V7_VM_AH_GJ_W_TW_QG
});

enum NotificationType { THE_2_DB_BB_WKJ_C_RB_JE9_PVR_W7_P_TA }

final notificationTypeValues = EnumValues({
  "2dbBbWkjCRbJE9pvrW7pTA==": NotificationType.THE_2_DB_BB_WKJ_C_RB_JE9_PVR_W7_P_TA
});

enum ErId { HY5_W_98_JQ_VH2_M0_NH_BH_C1_ZG, ZS_OUD_HU_UM9_ID5_SCH_AFG2_EQ }

final erIdValues = EnumValues({
  "Hy5W+98JqVh2m0NhBhC1zg==": ErId.HY5_W_98_JQ_VH2_M0_NH_BH_C1_ZG,
  "ZSOudHuUm9ID5SchAFG2EQ==": ErId.ZS_OUD_HU_UM9_ID5_SCH_AFG2_EQ
});

enum StoreId { BDOKP3_X_QR_L_JHKS_N2_F_O6_G_XW, UG_RQ_TAO9_G4_YG_SU5_NH_KWO_ZW, GOTA_RCNJE_GV_L_DX_UE1_OPB_UA }

final storeIdValues = EnumValues({
  "bdokp3xQrLJhksN2fO6gXw==": StoreId.BDOKP3_X_QR_L_JHKS_N2_F_O6_G_XW,
  "gotaRCNJEGvLDxUE1OpbUA==": StoreId.GOTA_RCNJE_GV_L_DX_UE1_OPB_UA,
  "UGRqTAO9G4ygSu5NHKwoZw==": StoreId.UG_RQ_TAO9_G4_YG_SU5_NH_KWO_ZW
});

enum StoreName { ND_LI4_R_NW_QK6_U_GW_YT_YKP_RW, AA_PU_UK_CH_ML_V3_BSE2_B2_VOQ, TDW7_D_HYL_GNF8_R_J_7_S_NB_A }

final storeNameValues = EnumValues({
  "aa/puUkCHMlV3bse2B2VOQ==": StoreName.AA_PU_UK_CH_ML_V3_BSE2_B2_VOQ,
  "ND/LI4RNwQK6UGwYTYkpRw==": StoreName.ND_LI4_R_NW_QK6_U_GW_YT_YKP_RW,
  "Tdw7D/Hyl/GNF8rJ/7SNbA==": StoreName.TDW7_D_HYL_GNF8_R_J_7_S_NB_A
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}