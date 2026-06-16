// 食堂菜品数据类型定义
export interface FoodItem {
  name: string;
  price: string;
}

export interface WindowItem {
  windowName: string;
  foodList: FoodItem[];
  image?: string; // 窗口图片（可选）
}

export interface FloorItem {
  floorName: string;
  windowList: WindowItem[];
}

// ✅ 桂园食堂完整数据（1-3楼全部匹配你的截图）
export const GUIYUAN_DATA: FloorItem[] = [
  // 桂园一楼
  {
    floorName: "一楼",
    windowList: [
      {

        windowName: "精品菜",
        foodList: [
          { name: "西红柿鸡蛋", price: "3元" },
          { name: "丝瓜毛豆", price: "3元" },
          { name: "蒜泥豆角", price: "3元" },
          { name: "青椒鸡蛋", price: "3元" },
          { name: "千叶豆腐", price: "3元" },
          { name: "油焖茄子", price: "3元" },
          { name: "山药木耳", price: "3元" },
          { name: "蒜泥西兰花", price: "4元" },
          { name: "红烧鸡翅", price: "4元" },
          { name: "红烧瓦块鱼", price: "4元" },
          { name: "木耳炒蛋", price: "4元" },
          { name: "豆角肉丝", price: "4元" },
          { name: "香辣鸡翅膀", price: "4元" },
          { name: "红烧带鱼", price: "5元" },
          { name: "山药炖排骨", price: "5元" },
          { name: "土豆烧排骨", price: "5元" },
          { name: "酱鸭腿", price: "5元" },
          { name: "盐水鸭", price: "5元" },
          { name: "红烧大块肉", price: "5元" },
          { name: "糖醋鱼", price: "5元" },
          { name: "粉蒸肉", price: "5元" },
          { name: "干煸长豆角", price: "3元" },
          { name: "香辣藕条", price: "3元" },
          { name: "鱼香茄子", price: "3元" },
          { name: "干锅有机花菜", price: "3元" },
          { name: "蒜黄炒鸡蛋", price: "3元" },
          { name: "白灼秋葵", price: "3元" },
          { name: "青椒腊肠", price: "5元" },
          { name: "鱼香肉丝", price: "5元" },
          { name: "糖醋鸡排", price: "5元" },
          { name: "蒜泥冬瓜", price: "2元" },
          { name: "韭菜豆芽", price: "2元" },
          { name: "蒜泥生瓜", price: "2元" },
          { name: "清炒南瓜丝", price: "2元" },
          { name: "卤水千张", price: "2元" }


        ]
      },
      {
        windowName: "辣上瘾",
        foodList: [
          { name: "招牌水煮肉片", price: "12元" },
          { name: "特色酸菜鱼", price: "12元" },
          { name: "一品肥牛", price: "12元" },
          { name: "小酥肉", price: "11元" },
          { name: "黄金鸡块", price: "11元" },
          { name: "金汤蛋饺", price: "11元" },
        { name: "麻辣花甲", price: "12元" }
    ]
  },
      {
        windowName: "精品面点",
        foodList: [
          { name: "白馒头", price: "0.5元" },
          { name: "煎包", price: "0.5元" },
          { name: "烧麦", price: "1元" },
          { name: "糍粑", price: "1元" },
          { name: "白煮蛋", price: "1元" },
          { name: "大肉包", price: "1元" },
          { name: "白菜粉丝包", price: "1元" },
          { name: "火腿花卷", price: "1元" },
          { name: "春卷", price: "1.5元" },
          { name: "豆角饼", price: "2.5元" },
          { name: "鸡蛋饼", price: "3元" },
          { name: "韭菜盒子", price: "3元" },
        ]
      },

      {

        windowName: "朱家小馆羊杂面",
        foodList: [
          { name: "小馆牛肉面", price: "12元" },
          { name: "小馆羊杂面", price: "11元" },
          { name: "小馆辣肉面", price: "11元" },
          { name: "小馆卤肉面", price: "12元" },
          { name: "小馆肉燥酸菜面", price: "9元" },
          { name: "小馆肉燥酸豆角面", price: "9元" },
          { name: "小馆酸菜面", price: "9元" },
          { name: "小馆酸豆角面", price: "9元" },
          { name: "小馆麻辣面", price: "9元" },
          { name: "小馆清汤面", price: "7元" },
          { name: "小馆麻辣拌面", price: "8元" },
          { name: "小馆肉燥拌面", price: "10元" },
          { name: "小馆辣肉拌面", price: "10元" },
          { name: "小馆酸豆角拌面", price: "11元" },
          { name: "小馆酸菜拌面", price: "11元" },
          { name: "小馆肉燥酸菜拌面", price: "11元" },
          { name: "小馆肉燥酸豆角拌面", price: "11元" },
          { name: "小馆卤肉拌面", price: "11元" },
          { name: "小馆酸辣拌面", price: "12元" },
          { name: "小馆卤杂拌面", price: "10元" },
          { name: "卤肠", price: "2元" },
          { name: "卤五花肉", price: "5元" },
          { name: "干豆腐", price: "2元" },
          { name: "卤蛋", price: "1元" },
          { name: "羊杂", price: "5元" },
          { name: "辣肉", price: "5元" },
          { name: "鸡腿", price: "2元" },
          { name: "狮子头", price: "2元" },

        ]
      },

      {
        windowName: "温馨粥道",
        foodList: [
          { name: "白米粥", price: "0.5元" },
          { name: "燕麦粥", price: "2元" },
          { name: "黑米粥", price: "2元" },
          { name: "胡辣汤", price: "2元" },
          { name: "米酒元宵", price: "2.5元" },
          { name: "桂花莲子粥", price: "2元" },
          { name: "小米南瓜粥", price: "2元" },
          { name: "皮蛋瘦肉粥", price: "3元" },
          { name: "紫薯粥", price: "2元" },
          { name: "八宝粥", price: "3元" },
          { name: "椰奶", price: "3元" },
          { name: "西米椰奶", price: "3元" },
          { name: "绿豆雪梨粥", price: "3元" },
          { name: "玫瑰柠檬酿", price: "4元" },
          { name: "杨梅荔枝饮", price: "4元" },

        ]
      },
      {
        windowName: "微香公",
        foodList: [
          { name: "奥尔良烤鸭饭", price: "12元" },
          { name: "黑椒烤鸭饭", price: "12元" },
          { name: "糖醋里脊饭", price: "12元" },
          { name: "红油口水鸡饭", price: "12元" },
          { name: "招牌烤鸭饭", price: "12元" },
          { name: "巴西烤肉饭", price: "12元" },
          { name: "铁板烤肉饭", price: "12元" },
          { name: "可乐鸡饭", price: "12元" },
          { name: "奥尔良鸡丁饭", price: "12元" },
          { name: "秘制酥鸭饭", price: "12元" },
        ]
      },
      {
        windowName: "萌煮",
        foodList: [
          { name: "青菜鸡蛋米线/面条/方便面/烫饭", price: "8元" },
          { name: "番茄鸡蛋米线/面条/方便面/烫饭", price: "8元" },
          { name: "火鸡面", price: "7元" },
          { name: "方腿金针菇米线/面条/方便面/烫饭", price: "8元" },
          { name: "鱼豆腐米线/面条/方便面/烫饭", price: "9元" },
          { name: "小龙虾拌面", price: "10元" },
          { name: "培根鸡蛋米线/面条/方便面/烫饭", price: "10元" },
          { name: "咸蛋黄火鸡面", price: "10元" },
          { name: "腊肠鸡蛋米线/面条/方便面/烫饭", price: "10元" },
          { name: "香酥鸡排米线/面条/方便面/烫饭", price: "11元" },
          { name: "麻酱拌面", price: "11元" },
          { name: "卤蛋丸子米线/面条/方便面/烫饭", price: "11元" },
          { name: "招牌拌面", price: "11元" },
          { name: "鸡丝米线/面条/方便面/烫饭", price: "11元" },
          { name: "招牌三鲜米线/面条/方便面/烫饭", price: "11元" },
          { name: "香酥鸡排拌面", price: "11元" },
          { name: "酸菜肉片米线/面条/方便面/烫饭", price: "11元" },
          { name: "水煮肉片拌面", price: "11元" },
          { name: "小酥肉米线/面条/方便面/烫饭", price: "11元" },
          { name: "小酥肉拌面", price: "11元" },
          { name: "红烧肉米线/面条/方便面/烫饭", price: "11元" },
          { name: "金汤肥牛米线/面条/方便面/烫饭", price: "11元" },
          { name: "酸菜肉片拌面", price: "11元" },
          { name: "虾仁鸡蛋米线/面条/方便面/烫饭", price: "12元" },
          { name: "椒麻鸡丝拌面", price: "12元" },
          { name: "青菜肉丝米线/面条/方便面/烫饭", price: "12元" },
          { name: "肉卷鱼丸米线/面条/方便面/烫饭", price: "12元" },
          { name: "青椒卤肉米线/面条/方便面/烫饭", price: "12元" },
          { name: "红烧肉拌面", price: "12元" },
          { name: "云南过桥米线", price: "12元" },
          { name: "青椒卤肉拌面", price: "12元" }
        ]
      },

      {
        windowName: "杂粮饼",
        foodList: [
          { name: "杂粮煎饼原味", price: "5元" },
          { name: "生煎包", price: "0.5元/个" },
          { name: "锅贴饺", price: "2元/6个" },
          { name: "杂粮饼", price: "1.5元" },
          { name: "夹里脊肉", price: "2元" },
          { name: "加火腿片", price: "2元" },
          { name: "肉松", price: "2元" }
        ]
      },
      {
        windowName: "超级双拼饭",
        foodList: [
          { name: "泰式咖喱鸡", price: "11元" },
          { name: "香辣鸡杂", price: "11元" },
          { name: "招牌脆皮鸡", price: "11元" },
          { name: "椒麻鸡", price: "12元" },
          { name: "手撕鸡", price: "12元" },
          { name: "土耳其烤肉", price: "12元" },
          { name: "辣子鸡", price: "12元" },
          { name: "秘汁肉丁", price: "12元" },
          { name: "糖醋鸡", price: "12元" },
          { name: "甜辣馋嘴鸡", price: "12元" },
          { name: "霸王炒鸡", price: "12元" },
          { name: "日式肉卷", price: "12元" },
          { name: "法式黑椒鸡", price: "12元" },
          { name: "半只鸡", price: "12元" },
          { name: "香酥鸡柳", price: "12元" },
          { name: "港式香卤肉香", price: "12元" },
          { name: "土耳其烤肉卤鸭翅根(4个)", price: "12元" },
          { name: "豆腐脑", price: "3元" },
          { name: "撒汤", price: "3元" }
        ]
      },
      {
        windowName: "炉知府",
        foodList: [
          { name: "香煎铁板鸡排饭", price: "12元" },
          { name: "五花肉酸菜饭", price: "12元" },
          { name: "烫烤螺丝椒五花肉饭", price: "12元" },
          { name: "五花肉金针菇饭", price: "12元" },
          { name: "烫烤五花肉饭", price: "12元" },
          { name: "烫烤培根饭", price: "12元" },
          { name: "烫烤五花肉娃娃菜", price: "12元" },
          { name: "肉沫土豆饭", price: "12元" },
          { name: "烫烤香辣鱼饭", price: "12元" }
        ]
      },
      {
        windowName: "燃她",
        foodList: [
          { name: "鸡肉条谷物饭", price: "11元" },
          { name: "煎腿排谷物饭", price: "11元" },
          { name: "酱烤鸭谷物饭", price: "11元" },
          { name: "黑椒肉排谷物饭", price: "11元" },
          { name: "牛肉谷物饭", price: "12元" },
          { name: "鸡肉条意面", price: "11元" },
          { name: "煎腿排意面", price: "11元" },
          { name: "鸡肉意面", price: "11元" },
          { name: "黑椒肉排意面", price: "11元" }
        ]
      },


    ]
  },
  // 桂园二楼
  {
    floorName: "二楼",
    windowList: [

      {
        windowName: "柴二爷",
        foodList: [
          { name: "招牌香辣鸡肉饭", price: "12元" },
          { name: "葱爆鸡腿肉饭", price: "12元" },
          { name: "港式菠萝鸡肉饭", price: "12元" },
          { name: "红油麻辣啤酒鸭饭", price: "12元" },
          { name: "糖醋炸鸡拌饭", price: "12元" },
          { name: "香煎鸡扒饭", price: "12元" },
          { name: "香煎牛扒饭", price: "12元" },
          { name: "短笋炒腊肉饭", price: "12元" },
          { name: "擂椒小炒肉饭", price: "12元" },
          { name: "鱼香肉丝饭", price: "12元" },
          { name: "风味鸭腿饭", price: "12元" },
         ]
  },

      {
        windowName: "前浪猛火炒饭",
        foodList: [
        { name: "火腿炒饭", price: "10元" },
      { name: "酸菜肉丝炒饭", price: "11元" },
      { name: "方式腊肠炒饭", price: "11元" },
      { name: "特色虾酱炒饭", price: "11元" },
      { name: "老干妈炒饭", price: "11元" },
      { name: "青椒肉丝炒饭", price: "11元" },
      { name: "招牌酸菜肉煲", price: "11元" },
      { name: "酸菜肉卷饭", price: "11元" },
      { name: "酸菜培根饭", price: "11元" },
      { name: "酸菜小酥肉饭", price: "11元" },
      { name: "酸菜牛肉炒面", price: "12元" },
      { name: "腊肠炒面", price: "12元" },
      { name: "卤肉炒面", price: "12元" },
      { name: "鸡蛋炒面", price: "12元" },
      { name: "火腿炒面", price: "12元" },
      { name: "培根炒面", price: "12元" },
      { name: "酸辣肉丝炒面", price: "12元" },
      { name: "青椒肉丝炒面", price: "12元" },
      { name: "招牌酸菜肉煲", price: "12元" },
      { name: "剁椒肉丝蛋炒饭", price: "12元" },
      { name: "奥尔良鸡腿排炒饭", price: "12元" },
      { name: "小香葱蛋炒饭", price: "12元" },
          ]
  },
      {

        windowName: "淮南牛肉汤",
        foodList: [
          { name: "鸡肉粉丝", price: "11元" },
          { name: "牛肉粉丝", price: "11元" },
          { name: "鸭血米线", price: "11元" },
          { name: "牛肉米线", price: "11元" },
          { name: "鸭血土豆粉", price: "11元" },
          { name: "牛肉土豆粉", price: "11元" },
          { name: "素粉丝", price: "8元" },
          { name: "素米线", price: "9元" },
          { name: "素土豆粉", price: "10元" },
          { name: "展沟烧饼", price: "4元" },
          { name: "鸡丝米线", price: "11元" },
          { name: "牛肉泡锅巴", price: "10元" },
          { name: "杂酱刀削面", price: "11元" },
          ]
      },
      {

        windowName: "瓦香鸡米饭",
        foodList: [
          { name: "瓦香鸡米饭", price: "12元" },
          { name: "瓦香年糕鸡", price: "11元" },
          { name: "瓦香手撕面筋", price: "11元" },
          { name: "瓦香脆皮豆腐", price: "11元" },
          { name: "瓦香小酥肉", price: "12元" },
          { name: "瓦香包菜", price: "8元" },
        ]
      },
      {

        windowName: "成都冒烤鸭",
        foodList: [
          { name: "冒烤鸭", price: "12元" },
          { name: "冒酥肉", price: "12元" },
          { name: "冒辣子鸡", price: "12元" },
          { name: "冒午餐肉", price: "12元" },
          { name: "冒辣肉", price: "12元" },
          { name: "冒土豆粉", price: "9元" },
          { name: "冒方便面", price: "9元" },
          ]
      },
      {
        windowName: "阿现烧腊",
        foodList: [
          { name: "广式烧鸭饭", price: "12元" },
          { name: "风味烧鸭饭", price: "12元" },
          { name: "广式卤肉饭", price: "12元" },
          { name: "粤味蒜香鸡饭", price: "12元" },
          { name: "黑椒五花叉烧", price: "12元" },
          { name: "广式腊肠饭", price: "12元" },
          { name: "广式猪脚饭", price: "12元" },
          { name: "战斧鸭腿饭", price: "12元" },
          { name: "黑椒猪扒饭", price: "12元" },
          { name: "黑椒叉烧饭", price: "12元" },
          { name: "阿现肉肠饭", price: "12元" },
          { name: "潮汕肉卷饭", price: "12元" },
          { name: "蜜汁叉烧饭", price: "12元" },
          { name: "猪脚拼鸭腿", price: "3元" },
          { name: "叉烧拼猪脚", price: "3元" },
          { name: "叉烧拼烧鸭", price: "3元" },
          { name: "叉烧拼卤肉", price: "3元" },
          { name: "叉烧拼腊肠", price: "3元" },
          { name: "烧鸭拼卤肉", price: "3元" },
          { name: "烧鸭拼腊肠", price: "3元" },
          { name: "辣卤鸭头", price: "2元" },
          { name: "鸭脖子", price: "2元" },
          { name: "战斧鸭腿", price: "8元" },
        ]
      },
      {
        windowName: "特色水煎包",
        foodList: [
          { name: "水煮包（素）", price: "1元" },
          { name: "水煎包（素）", price: "1元" },
          { name: "红薯干粥", price: "2.5元" },
          { name: "红枣豆浆", price: "2.5元" },
          { name: "菜馍", price: "3元" },
          { name: "撒汤", price: "3元" },
        ]
      },
      {

        windowName: "串烧饭",
        foodList: [
          { name: "鸡排饭", price: "10元" },
          { name: "里脊肉饭", price: "10元" },
          { name: "烤肉饭", price: "12元" },
          { name: "牛排饭", price: "12元" },
          ]
      },
      {
        windowName: "牛伯叔铁锅炖",
        foodList: [
          { name: "素菜锅底", price: "10元" },
          { name: "肉末茄子/面饼", price: "2元" },
          { name: "小酥肉/肉片", price: "3元" },
          { name: "烤肉/鱼块", price: "4元" },
          { name: "鸡块/烤鸭", price: "5元" },
          ]
      },
      {

        windowName: "正宗柳州螺狮粉",
        foodList: [
          { name: "招牌柳州螺狮粉", price: "12元" },
          { name: "炸蛋", price: "3元" },
          { name: "虎皮鸡爪", price: "3.5元" },
          { name: "柳州黄皮鸭掌", price: "3.5元" },
          { name: "油豆泡", price: "1/3个元" },
          { name: "吸汤兰花干", price: "2元" },
          { name: "空心菜", price: "3元" },
          { name: "干贡菜", price: "3元" },
          ]
      },
      {

        windowName: "富庄阁",
        foodList: [
          { name: "烤鸭拌饭", price: "12元" },
          ]
      },
      {

        windowName: "超大猪排",
        foodList: [
          { name: "大脸鸡排蛋包饭", price: "11元" },
          { name: "五香猪扒蛋包饭", price: "11元" },
          { name: "原味蛋包饭", price: "11元" },
          { name: "黑椒烤肠蛋包饭", price: "11元" },
          { name: "红烧狮子头蛋包饭", price: "11元" },
          { name: "唐扬鸡块蛋包饭", price: "11元" },
          { name: "风情柳叶鸡蛋包饭", price: "11元" },
          ]
      },
      {

        windowName: "精品小碗菜",
        foodList: [
          { name: "宫爆鸡丁", price: "5元" },
          { name: "尖椒脆骨", price: "5元" },
          { name: "孜然烤肉", price: "5元" },
          { name: "孜然肥牛", price: "5元" },
          { name: "酸菜肉片", price: "5元" },
          { name: "蒜苗回锅肉", price: "5元" },
          { name: "海带烧肉", price: "5元" },
          { name: "干张结烧肉", price: "5元" },
          { name: "麻辣鸭块", price: "5元" },
          { name: "蚝油肉片", price: "5元" },
          { name: "农家小炒肉", price: "5元" },
          { name: "红烧鸡腿", price: "5元" },
          { name: "冬瓜排骨", price: "5元" },
          { name: "毛豆米肉丝", price: "4元" },
          { name: "剁椒鱼块", price: "5元" },
          { name: "辣椒肉柳", price: "4元" },
          { name: "口水鸡", price: "4元" },
          { name: "辣子鸡丁", price: "4元" },
          { name: "杭椒肉柳", price: "4元" },
          { name: "干锅花菜", price: "3元" },
          { name: "鱼香茄子", price: "3元" },
          { name: "西红柿炒鸡蛋", price: "3元" },
          { name: "青椒土豆肉丝", price: "3元" },
          { name: "千叶豆腐", price: "3元" },
          { name: "三河小炒", price: "3元" },
          { name: "炒芹菜", price: "3元" },
          { name: "炒时蔬", price: "3元" },
          { name: "青椒土豆丝", price: "3元" },
          { name: "青椒绿豆芽", price: "3元" },
          { name: "麻婆豆腐", price: "3元" },
          { name: "平包菜炒粉丝", price: "3元" },
      ]
      },
    {

        windowName: "辣椒炒肉",
        foodList: [
          { name: "招牌辣椒炒肉", price: "12元" },
          { name: "下饭香干炒肉", price: "12元" },
          { name: "湘西小炒鸡", price: "12元" },
          { name: "家常一碗香", price: "11元" },
          { name: "香辣鸡杂", price: "12元" },
          { name: "外婆下饭菜炒肉", price: "11元" },
          { name: "香辣炒肉", price: "12元" },
          { name: "莴笋炒肉", price: "12元" },
          { name: "腐竹炒肉", price: "12元" },
          { name: "白木耳炒肉", price: "12元" },
          ]
      },

    ]
  },
  // ✅ 新增：桂园三楼（对应本次截图菜单）
  {
    floorName: "三楼",
    windowList: [
      {
        windowName: "SALAD",
        foodList: [
          { name: "孜香蜜汁鸡排", price: "11元" },
          { name: "柠香鸡丝", price: "11元" },
          { name: "照烧鸡肉饭", price: "11元" },
          { name: "黑椒牛肉饼", price: "11元" },
          { name: "意式番茄意面", price: "11元" },
          { name: "法式黑椒意面", price: "11元" },
          { name: "干烤香骨鸡", price: "11元" },
          { name: "麻辣鸡丝", price: "11元" },
          { name: "金枪鱼拌饭", price: "11元" },
          { name: "嫩烤鱼肉饼", price: "11元" },
          { name: "奶香咖喱意面", price: "11元" },
          { name: "泰式甜辣意面", price: "11元" }
        ]
      },

      {
        windowName: "重庆鸡公煲",
        foodList: [
          { name: "鸡公煲", price: "12元" },
          { name: "排骨煲", price: "12元" },
          { name: "三鲜煲", price: "12元" },
          { name: "鸭肉煲", price: "12元" },
          { name: "酥鱼煲", price: "12元" },
          { name: "千叶肉片豆腐煲", price: "12元" },
          { name: "肉卷煲", price: "11元" },
          { name: "干鸭煲", price: "11元" },
          { name: "肉末茄子煲", price: "10元" },
          { name: "肉末豆腐煲", price: "10元" }
        ]
      },

      {
        windowName: "各种盖浇饭",
        foodList: [
          { name: "麻辣豆腐", price: "9元" },
          { name: "西红柿炒蛋", price: "10元" },
          { name: "香干肉丝", price: "11元" },
          { name: "黑椒肉柳", price: "11.6元" },
          { name: "孜然肉片", price: "11.6元" },
          { name: "土豆肉丝", price: "10元" },
          { name: "爆炒肥肠", price: "12元" },
          { name: "香辣鸡杂", price: "12元" },
          { name: "肉沫茄子", price: "11元" },
          { name: "宫保鸡丁", price: "11.6元" },
          { name: "尖椒回锅肉", price: "12元" },
          { name: "孜然肉柳", price: "11.5元" },
          { name: "小炒鸡", price: "12元" },
          { name: "糖醋里脊", price: "12元" },
          { name: "红烧肉", price: "12元" },
          { name: "金针菇肉卷", price: "12元" },
          { name: "肉卷砂锅", price: "12元" },
          { name: "酱鸭砂锅", price: "12元" },
          { name: "排骨砂锅", price: "12元" },
          { name: "鸡块砂锅", price: "12元" },
          { name: "三鲜砂锅", price: "12元" },
          { name: "酱鱼砂锅", price: "12元" },
          { name: "酥鱼砂锅", price: "12元" },
          { name: "牛杂锅仔", price: "10元" },
          { name: "鱼香肉丝", price: "11元" }
        ]
      },
      {
        windowName: "袁记云饺",
        foodList: [
          { name: "玉米鲜肉饺", price: "12元" },
          { name: "韭菜鲜肉饺", price: "12元" },
          { name: "冬菇马蹄鲜肉饺", price: "12元" },
          { name: "紫菜鲜肉饺", price: "12元" },
          { name: "白菜鲜肉饺", price: "12元" },
          { name: "玉米鲜肉云吞", price: "12元" },
          { name: "紫菜鲜肉云吞", price: "12元" },
          { name: "冬菇马蹄鲜肉云吞", price: "12元" },
          { name: "鲜肉云吞", price: "12元" },
          { name: "鲜榨玉米汁", price: "5元" }
        ]
      },
      {
        windowName: "旋转小火锅",
        foodList: [
          { name: "香辣红油", price: "2.5元" },
          { name: "清汤牛油", price: "2.5元" },
          { name: "藤椒", price: "2元" },
          { name: "红酸菜金汤", price: "2元" },
          { name: "泰国冬阴功", price: "2.5元" },
          { name: "养生菌鸡", price: "2.5元" },
          { name: "竹签子", price: "1元" },
          { name: "紫色签夹", price: "1.5元" },
          { name: "蓝色签夹", price: "2元" },
          { name: "黄色签夹", price: "3元" },
          { name: "肥牛卷", price: "10元" },
          { name: "肥羊卷", price: "10元" },
          { name: "毛肚", price: "10元" },
          { name: "安井虾滑", price: "12元" }
        ]
      },
      {
        windowName: "原切烤肉/酒酿",
        foodList: [
          { name: "原切烤肉/酒酿", price: "12元" },
          { name: "蒜香烤肉饭", price: "12元" },
          { name: "大份烤肉饭", price: "12元" },
          { name: "蒜香烤肉套饭", price: "12元" },
          { name: "酒酿小汤圆", price: "6元" }
        ]
      },

      {
        windowName: "舌尖大师",
        foodList: [
          { name: "精选吃到撑套餐", price: "59元" },
          { name: "二人不纠结套餐", price: "66元" },
          { name: "经典双人餐", price: "49元" },
          { name: "舌尖大师三人经典套餐", price: "96元" },
          { name: "卤香牛肉", price: "22元" },
          { name: "红烧卤牛肉", price: "20元" },
          { name: "卤香五花肉", price: "20元" },
          { name: "烤里脊肉", price: "11元" },
          { name: "迷你广式香肠", price: "10元" },
          { name: "鸡蛋干", price: "6元" },
          { name: "毛肚", price: "16元" },
          { name: "鹌鹑蛋", price: "7元" },
          { name: "鸭血", price: "4.8元" },
          { name: "鲜鸡肉片", price: "10元" },
          { name: "鲜巴沙鱼", price: "16元" },
          { name: "黑椒肉柳", price: "13元" },
          { name: "牛肉卷", price: "20元" },
          { name: "羊肉卷", price: "20元" },
          { name: "麻辣肉片", price: "11元" },
          { name: "雪花培根", price: "9元" },
          { name: "乌鸡卷", price: "16.8元" },
          { name: "麻辣牛肚", price: "22元" },
          { name: "鲜牛肉片", price: "16元" },
          { name: "魔芋毛肚", price: "8元" },
          { name: "卤鸭肠", price: "18元" },
          { name: "基围虾", price: "20元" },
          { name: "腐竹", price: "8元" },
          { name: "面筋", price: "4元" },
          { name: "干张", price: "5.8元" },
          { name: "豆腐泡", price: "5元" },
          { name: "脆皮豆腐", price: "6.8元" },
          { name: "鱼籽福袋", price: "17元" },
          { name: "豆油皮", price: "5元" },
          { name: "鲜土豆片", price: "4元" },
          { name: "鲜莴笋", price: "6元" },
          { name: "冬瓜片", price: "2.8元" },
          { name: "海带", price: "3.7元" },
          { name: "脆笋丝", price: "6元" },
          { name: "年糕", price: "4.7元" },
          { name: "娃娃菜", price: "6元" },
          { name: "甜玉米片", price: "4元" },
          { name: "贡菜", price: "10元" },
          { name: "魔芋结", price: "8元" },
          { name: "鲜藕片", price: "5元" },
          { name: "生态小白菜", price: "4元" },
          { name: "生菜", price: "4.8元" },
          { name: "安井鱼豆腐", price: "8元" },
          { name: "安井爆汁鱼丸", price: "8.8元" },
          { name: "安井撒尿牛丸", price: "9元" },
          { name: "安井蟹柳棒", price: "8元" },
          { name: "安井亲亲肠", price: "8.8元" },
          { name: "安井蟹排", price: "8元" },
          { name: "安井小油条", price: "4元" },
          { name: "安井狮子头", price: "8元" },
          { name: "金针菇", price: "4.8元" },
          { name: "房县香菇", price: "7元" },
          { name: "鲜香菇", price: "7元" },
          { name: "小酥肉", price: "9元" },
          { name: "东北大米饭", price: "1元" },
          { name: "土豆粉", price: "3元" },
          { name: "川粉", price: "5元" },
          { name: "方便面", price: "3.5元" },
          { name: "汉口热干面", price: "3.8元" }
        ]
      }
    ]
  }
];

// 其他食堂数据可以按同样格式添加
// 例如：桔园食堂、梅园食堂等
export const JUYUAN_DATA: FloorItem[] = [
  //待补充
  // 桔园三楼框架（按桂园格式，无菜谱）
  {
    floorName: "一楼",
    windowList: [
      {
        windowName: "麻辣烫",
        foodList: [
          { name: "麻辣烫", price: "1.78元/50克" },
          { name: "麻辣烫米饭", price: "" },
          { name: "麻辣烫打包盒", price: "" },
          { name: "麻辣香锅/麻辣拌", price: "1.78元/50克 (荤素同价)" }
        ]
      },

      {
        windowName: "烤鸭饭",
        foodList: [
          { name: "烤鸭饭", price: "12元/份" },
          { name: "烤鸭板", price: "12元/份" },
          { name: "烤鸭半只", price: "20元" },
          { name: "鸭腿", price: "6元/个" },
          { name: "半份菜", price: "5元/半份" }
        ]
      },

      {
        windowName: "自选菜",
        foodList: [
          { name: "蒸鸡蛋", price: "1.50元" },
          { name: "上汤娃娃菜", price: "2.00元" },
          { name: "川味鸭血", price: "2.00元" },
          { name: "酱焖冬瓜", price: "2.00元" },
          { name: "酸辣包菜", price: "2.00元" },
          { name: "干煸长豆角", price: "3.00元" },
          { name: "香辣藕条", price: "3.00元" },
          { name: "鱼香茄子", price: "3.00元" },
          { name: "西红柿鸡蛋", price: "3.00元" },
          { name: "干锅有机花菜", price: "3.50元" },
          { name: "蒜黄炒鸡蛋", price: "3.50元" },
          { name: "白灼秋葵", price: "3.50元" },
          { name: "青椒腊肠", price: "4.00元" },
          { name: "鱼香肉丝", price: "4.00元" },
          { name: "糖醋鸡排", price: "4.50元" },
          { name: "香辣鸡碎肉", price: "4.50元" },
          { name: "歌乐山辣子鸡", price: "5.00元" }
        ]
      },
      {
        windowName: "营养早餐",
        foodList: [
          { name: "鲜汁肉包", price: "1.50元" },
          { name: "现磨豆浆", price: "1.50元" },
          { name: "肉丁烧麦", price: "1.50元" },
          { name: "空心大麻球", price: "1.50元" },
          { name: "梅干菜扣肉包", price: "1.50元" },
          { name: "桂花糕", price: "2.00元" },
          { name: "热狗卷", price: "2.00元" },
          { name: "红枣发糕", price: "2.00元" },
          { name: "南瓜发糕", price: "2.00元" },
          { name: "紫薯发糕", price: "2.00元" },
          { name: "红枣豆浆", price: "2.00元" },
          { name: "现磨花生浆", price: "2.00元" },
          { name: "小笼包", price: "6.00元" },
          { name: "红豆卷", price: "3.00元" },
          { name: "现磨玉米汁", price: "3.00元" },
          { name: "蜜枣粽", price: "3.50元" },
          { name: "公婆饼", price: "4.00元" },
          { name: "五花肉粽", price: "4.00元" },
          { name: "东北糯玉米", price: "4.00元" },
          { name: "手工阿萨姆奶茶", price: "5.00元" },
          { name: "白馒头", price: "0.50元" },
          { name: "雪菜包", price: "1.00元" },
          { name: "青菜香菇包", price: "1.00元" },
          { name: "肉沫粉丝包", price: "1.00元" },
          { name: "肉沫海带包", price: "1.00元" },
          { name: "家常豆腐包", price: "1.00元" },
          { name: "玫瑰豆沙包", price: "1.00元" },
          { name: "鱼香肉丝包", price: "1.50元" },
          { name: "春卷", price: "1.50元" },
          { name: "糖糕", price: "1.50元" },
          { name: "水煮蛋", price: "1.00元" },
          { name: "奶黄包", price: "1.50元" },
          { name: "馒头", price: "0.5元" },
          { name: "花卷", price: "1.5元" },
          { name: "蒸饺", price: "0.5元" },
          { name: "鸡蛋", price: "1元" },
          { name: "豆浆", price: "1.5元" },
          { name: "糍粑", price: "1.5元" },
          { name: "麻球", price: "1.5元" },
          { name: "菜饺", price: "2元" },
          { name: "土豆卷", price: "3元" },
          { name: "青菜包", price: "1元" },
          { name: "肉包", price: "1.5元" },
          { name: "梅干菜包", price: "1.5元" },
          { name: "粉丝包", price: "1元" },
          { name: "豆沙包", price: "1元" },
          { name: "烧麦", price: "1.5元" },
          { name: "鱼香肉丝饼", price: "4元" },
          { name: "羌饼", price: "2.5元" },
          { name: "肉夹馍", price: "4元" },
          { name: "酸奶麻花", price: "4元" },
          { name: "红糖馒头", price: "2元" },
          { name: "牛肉饼", price: "4元" },
          { name: "土豆鸡蛋饼", price: "3元" },
          { name: "火腿鸡蛋片", price: "3元" },
          { name: "米饺", price: "1.5元" },
          { name: "玉米棒", price: "3.5元" },
          { name: "卡通包", price: "1.5元" },
          { name: "桂花糕", price: "2.5元" },
          { name: "马拉松", price: "2.5元" },
          { name: "窝窝头", price: "2元" },
          { name: "饭团", price: "3元" },
          { name: "豆腐包", price: "1元" },
          { name: "鸡肉饼", price: "4元" },
          { name: "京东肉饼", price: "4元" },
          { name: "猪肉粉丝煎饺", price: "1.5元/个" },
          { name: "猪肉煎饺", price: "1元/2个" }
        ]
      },
      {
        windowName: "温馨粥道",
        foodList: [
          { name: "白米粥", price: "0.5元/碗" },
          { name: "燕麦粥", price: "2元" },
          { name: "黑米粥", price: "1元" },
          { name: "胡辣汤", price: "2元" },
          { name: "米酒元宵", price: "2.5元" },
          { name: "桂花莲子粥", price: "2.5元" },
          { name: "小米南瓜粥", price: "2.5元" },
          { name: "皮蛋瘦肉粥", price: "2.5元" },
          { name: "紫薯粥", price: "2.5元" },
          { name: "八宝粥", price: "2.5元" },
          { name: "椰奶", price: "2.5元" },
          { name: "燕麦+椰奶", price: "2.5元" },
          { name: "黑米+椰奶", price: "2.5元" },
          { name: "紫薯+椰奶", price: "2.5元" },
          { name: "桂花莲子+椰奶", price: "2.5元" },
          { name: "绿豆汤", price: "2元" },
          { name: "酸梅汤", price: "3元" },
          { name: "蓝莓酸奶", price: "4元" },
          { name: "现磨花生豆浆", price: "2.5元/杯" },
          { name: "蜜果凝香粥", price: "3.2元" }
        ]
      },
      {
        windowName: "酱香饼",
        foodList: [
          { name: "发面小笼包", price: "6元/笼（7个）" },
          { name: "小笼灌汤包", price: "7元/笼（7个）" },
          { name: "小笼蒸饺", price: "6元/笼（7个）" },
          { name: "千层饼", price: "2.5元" },
          { name: "酱香饼", price: "2.5元" },
          { name: "鸡蛋饼", price: "2.5元" },
          { name: "土豆饼", price: "3元" },
          { name: "青椒鸡蛋饼", price: "3元" },
          { name: "肉夹馍", price: "6元" },
          { name: "肉饼", price: "4元" },
          { name: "酥饼", price: "3元" },
          { name: "生煎包", price: "1元" },
          { name: "荷包蛋", price: "1.5元" },
          { name: "豆浆", price: "1.5元" }
        ]
      },
      {
        windowName: "陕行记油泼面",
        foodList: [
          { name: "岐山臊子面（酸辣）", price: "10元" },
          { name: "农家肉臊子面（酱香）", price: "10元" },
          { name: "香辣鸡丁面（辣）", price: "10元" },
          { name: "香辣鸡蛋面（辣）", price: "10元" },
          { name: "雪菜肉丝面（辣）", price: "9元" },
          { name: "鸡丝汤面（不辣）", price: "10元" },
          { name: "养生清汤面（不辣）", price: "7元" },
          { name: "红烧牛肉面（不辣）", price: "12元" },
          { name: "香辣牛肉面（辣）", price: "12元" },
          { name: "香辣排骨面（辣）", price: "12元" },
          { name: "西红柿鸡蛋面（不辣）", price: "8元" },
          { name: "清捞拌面（不辣）", price: "12元" },
          { name: "麻辣肉丁面（辣）", price: "11元" },
          { name: "油泼裤带面（荤/素）（辣/不辣）", price: "12元/10元" },
          { name: "风味油泼面（素）（辣/不辣）", price: "10元" },
          { name: "鸡丁油泼面（辣）", price: "12元" },
          { name: "鸡杂油泼面（辣）", price: "12元" },
          { name: "臊子油泼面（辣）", price: "12元" },
          { name: "牛肉拌面（辣/不辣）", price: "12元" },
          { name: "肉臊子油泼面（辣）", price: "11元" },
          { name: "鸡丁油泼面（辣）", price: "10元" },
          { name: "鸡杂油泼面（辣）", price: "10元" },
          { name: "老西安炸酱面（不辣）", price: "10元" },
          { name: "秘制剁椒面（辣）", price: "8元" },
          { name: "葱油拌面（不辣）", price: "7元" },
          { name: "鸡丝拌面（麻辣）", price: "10元" },
          { name: "葱油鸡丝拌面（不辣）", price: "11元" },
          { name: "西红柿鸡蛋拌面（不辣）", price: "8元" },
          { name: "雪菜肉丝拌面（辣）", price: "9元" },
          { name: "炸蛋", price: "2元/个" },
          { name: "豆干", price: "1.5元/2片" },
          { name: "卤蛋", price: "1.5元/个" },
          { name: "煎蛋", price: "1.5元/个" },
          { name: "鸡丁", price: "4元/份" },
          { name: "鸡杂", price: "4元/份" },
          { name: "臊子肉", price: "4元/份" },
          { name: "鸡丝", price: "4元/份" }
        ]
      },
      {
        windowName: "玖昊猪土豆泥拌饭",
        foodList: [
          { name: "甜辣黄焖鸡", price: "12元" },
          { name: "番茄牛肉", price: "12元" },
          { name: "武汉黑鸭", price: "12元" },
          { name: "超级卤肉", price: "12元" },
          { name: "椒麻手撕鸡", price: "12元" },
          { name: "糖醋排骨", price: "12元" },
          { name: "口水鸡", price: "12元" },
          { name: "可乐鸡翅根", price: "12元" },
          { name: "泰式咖喱鸡", price: "11元" },
          { name: "霸王炒鸡", price: "12元" },
          { name: "韩式孜然鸡", price: "12元" },
          { name: "爆汁牛肉", price: "12元" },
          { name: "法式黑椒鸡", price: "12元" },
          { name: "蟹柳茄子", price: "11元" }
        ]
      },
      {
        windowName: "云南生烫牛肉米线",
        foodList: [
          { name: "招牌肉酱米线", price: "9元" },
          { name: "山野泡椒肉酱米线", price: "10元" },
          { name: "川味肉酱拌粉", price: "10元" },
          { name: "公主番茄米线", price: "9元" }
        ]
      },
      {
        windowName: "粗粮渔粉",
        foodList: [
          { name: "灵魂拌粉", price: "8元" },
          { name: "粗粮素粉", price: "8元" },
          { name: "香辣鱼豆腐粉", price: "10元" },
          { name: "香辣蟹排粉", price: "10元" },
          { name: "酸汤鱼丸粉", price: "11元" },
          { name: "番茄鱼丸粉", price: "11元" },
          { name: "番茄鱼豆腐粉", price: "11元" },
          { name: "酸汤鱼豆腐粉", price: "11元" },
          { name: "香辣鱼丸粉", price: "11元" },
          { name: "酸汤蟹排粉", price: "11元" },
          { name: "金汤玉米粉", price: "11元" },
          { name: "番茄小酥肉粉", price: "12元" },
          { name: "酸汤小酥肉粉", price: "12元" },
          { name: "麻辣小酥肉粉", price: "12元" },
          { name: "招牌渔粉", price: "12元" },
          { name: "诱惑番茄渔粉", price: "12元" },
          { name: "激情椒麻渔粉", price: "12元" },
          { name: "奇妙酸汤渔粉", price: "12元" },
          { name: "粗粮麻辣渔粉", price: "12元" },
          { name: "激情椒麻肥牛粉", price: "12元" },
          { name: "诱惑番茄肥牛粉", price: "12元" },
          { name: "酸汤肥牛粉", price: "12元" },
          { name: "劲爆肥牛粉", price: "12元" },
          { name: "加菜（煎鸡蛋）", price: "1.5元" },
          { name: "加菜（鱼豆腐）", price: "2元" },
          { name: "加菜（炸蛋）", price: "2元" },
          { name: "加菜（鱼丸）", price: "2元" },
          { name: "加菜（小酥肉）", price: "5元" },
          { name: "加菜（蟹排）", price: "2元" },
          { name: "加菜（肥牛卷）", price: "4元" }
        ]
      },
      {
        windowName: "517牛肉蛋炒饭/盖浇饭",
        foodList: [
          { name: "招牌牛肉蛋炒饭", price: "12元" },
          { name: "扬州碎金炒饭", price: "12元" },
          { name: "孜然猪蹄蛋炒饭", price: "12元" },
          { name: "雪菜肉丝蛋炒饭", price: "10元" },
          { name: "红葱香酱牛肉蛋炒饭", price: "12元" },
          { name: "香辣牛肉蛋炒饭", price: "12元" },
          { name: "孜然腊肠蛋炒饭", price: "11元" },
          { name: "招牌上海火腿蛋炒面", price: "11元" },
          { name: "正宗广式干炒牛河", price: "12元" },
          { name: "蒜香排骨蛋炒饭", price: "12元" },
          { name: "剁椒肉丝蛋炒饭", price: "10元" },
          { name: "奥尔良鸡腿排炒饭", price: "12元" },
          { name: "小香葱蛋炒饭", price: "7元" },
          { name: "农家一碗香盖浇饭", price: "12元" },
          { name: "香辣土豆炒鸡蛋盖浇饭", price: "12元" },
          { name: "湖南小炒肉盖浇饭", price: "12元" },
          { name: "小炒黄牛肉盖浇饭", price: "12元" },
          { name: "回锅肉盖浇饭", price: "12元" },
          { name: "蒜香排骨盖浇饭", price: "12元" },
          { name: "劲爆牛肉茄子盖浇饭", price: "12元" },
          { name: "牛肉番茄鸡蛋盖浇饭", price: "12元" },
          { name: "加料卤蛋", price: "1.5元" },
          { name: "加料鸡腿肉", price: "4.5元" },
          { name: "加料鸡腿排骨", price: "5元" },
          { name: "加料蒜香排骨", price: "5元" },
          { name: "加料火腿肉丝", price: "3元" },
          { name: "加料牛肉", price: "5元" }
        ]
      },
      {
        windowName: "申向国鸡柳卷饼",
        foodList: [
          { name: "香酥鸡柳卷饼 (小份)", price: "9元" },
          { name: "香酥鸡柳卷饼 (大份)", price: "11元" },
          { name: "方便面", price: "6元" },
          { name: "干拌面", price: "6元" },
          { name: "火鸡拌面", price: "7元" },
          { name: "乌冬面拉面范系列", price: "7元" }
        ]
      },
      {
        windowName: "手工馄饨",
        foodList: [
          { name: "鲜肉小馄饨", price: "7元/20个、9元/30个" },
          { name: "荠菜肉小馄饨", price: "7元/20个、9元/30个" },
          { name: "玉米肉小馄饨", price: "7元/20个、9元/30个" },
          { name: "虾滑肉小馄饨", price: "11元/26个" },
          { name: "干拌馄饨", price: "加1元" },
          { name: "小龙虾风味", price: "1元" },
          { name: "原味麻酱", price: "1元" },
          { name: "香辣麻酱", price: "1元" },
          { name: "鲜肉大馄饨", price: "11元/10个、12元/12个" },
          { name: "芹菜肉大馄饨", price: "11元/10个、12元/12个" },
          { name: "荠菜肉大馄饨", price: "11元/10个、12元/12个" },
          { name: "玉米肉大馄饨", price: "11元/10个、12元/12个" },
          { name: "香菇肉大馄饨", price: "11元/10个、12元/12个" },
          { name: "虾仁肉大馄饨", price: "12元/9个" },
          { name: "皮蛋肉大馄饨", price: "12元/9个" },
          { name: "黑芝麻汤圆", price: "10元/18个" },
          { name: "韭菜鸡蛋水饺", price: "10元/15个、12元/18个" },
          { name: "玉米猪肉水饺", price: "10元/15个、12元/18个" },
          { name: "白菜猪肉水饺", price: "10元/15个、12元/18个" },
          { name: "芹菜猪肉水饺", price: "10元/15个、12元/18个" },
          { name: "荠菜猪肉水饺", price: "10元/15个、12元/18个" }
        ]
      },

      {
        windowName: "掉渣饼",
        foodList: [
          { name: "土豆", price: "1元" },
          { name: "娃娃菜", price: "1元" },
          { name: "青椒", price: "1元" },
          { name: "包菜", price: "1元" },
          { name: "金针菇", price: "1.5元" },
          { name: "千叶豆腐", price: "1.5元" },
          { name: "豆角", price: "2元" },
          { name: "花菜", price: "2元" },
          { name: "黄金豆扣", price: "2元" },
          { name: "手工面筋", price: "2元" },
          { name: "雪花培根", price: "2元" },
          { name: "火腿肠", price: "2元" },
          { name: "包浆素鸡串", price: "2元" },
          { name: "鱼豆腐", price: "2.5元" },
          { name: "掉渣饼", price: "3.5元" },
          { name: "包浆茄子", price: "2.5元" },
          { name: "包浆藕片", price: "2.5元" },
          { name: "烤五花肉", price: "3元" },
          { name: "澳洲大肉串", price: "3元" },
          { name: "骨肉相连", price: "3元" },
          { name: "铁板大里脊", price: "3元" },
          { name: "火龙串", price: "3元" },
          { name: "童年大火腿", price: "3元" },
          { name: "油豆腐", price: "3元" },
          { name: "黑椒麦穗肠", price: "3元" },
          { name: "金丝鸡柳棒", price: "3元" },
          { name: "纯肉排", price: "5元" }
        ]
      }
    ]
  },
// 桔园三楼框架（按桂园格式，无菜谱）
{
  floorName: "二楼",
  windowList: [
    {
      windowName: "麻辣烫",
      foodList: [
        { name: "麻辣烫/麻辣香锅/麻辣拌", price: "1.75元/50克" },
        { name: "米饭加0.5元，免费续饭", price: "" },
        { name: "起烫", price: "9.9元起" },
      ]
    },

    {
      windowName: "自选窗口",
      foodList: [
        { name: "大锅烧豆腐", price: "按窗口实际标价计价" },
        { name: "秘制红烧肉", price: "按窗口实际标价计价" },
      ]
    },

    {
      windowName: "烤鸭饭",
      foodList: [
        { name: "烤鸭饭", price: "12元/份" },
        { name: "特色小菜、鸭头鸭脖、米饭", price: "免费" },
      ]
    },

    {
      windowName: "酸菜煲/椒麻鸡/黑鸭煲",
      image: "jmj.png",
      foodList: [
        { name: "酸菜肉煲+米饭", price: "12元" },
        { name: "酸菜小酥肉煲+米饭", price: "12元" },
        { name: "酸菜手撕鸡煲+米饭", price: "12元" },
        { name: "酸菜肉卷煲+米饭", price: "12元" },
        { name: "酸菜鱼煲+米饭", price: "12元" },
        { name: "番茄小酥肉+米饭", price: "12元" },
        { name: "番茄肉片+米饭", price: "12元" },
        { name: "番茄手撕鸡+米饭", price: "12元" },
        { name: "藤椒小酥肉+米饭", price: "12元" },
        { name: "藤椒肉片+米饭", price: "12元" },
        { name: "藤椒手撕鸡+米饭", price: "12元" },
        { name: "极品椒麻鸡+米饭", price: "12元" },
        { name: "椒麻肉片+米饭", price: "12元" },
        { name: "椒麻小酥肉+米饭", price: "12元" },
        { name: "椒麻肉卷+米饭", price: "12元" },
        { name: "椒麻黑椒鸡扒+米饭", price: "12元" },
        { name: "椒麻狮子头+米饭", price: "12元" },
        { name: "椒麻培根+米饭", price: "12元" },
        { name: "椒麻鱼片+米饭", price: "12元" },
        { name: "回味黑鸭煲+米饭", price: "11元" },
        { name: "黑鸭排骨煲+米饭", price: "12元" },
        { name: "黑鸭酥肉煲+米饭", price: "12元" },
        { name: "黑鸭鱼片煲+米饭", price: "12元" }
      ]
    },

    {
      windowName: "川红油手工水饺/特色盖浇面/汤",
      foodList: [
        { name: "手工水饺", price: "1元/2个, 8元起卖" },
        { name: "馄饨", price: "8元/小, 9元/大" },
        { name: "汤圆", price: "9元/碗" },
        { name: "加鸡蛋", price: "2元/个" },
        { name: "加牛肉", price: "6元/份" },
        { name: "特色盖浇面", price: "10-12元" },
        { name: "汤面", price: "11-12元" }
      ]
    },

    {
      windowName: "赵阿姨拌饭",
      foodList: [
        { name: "素什锦拌饭", price: "8元" },
        { name: "辣子鸡拌饭", price: "10元" },
        { name: "香辣烤肉拌饭", price: "10元" },
        { name: "孜然烤肉拌饭", price: "10元" },
        { name: "黑椒烤肉拌饭", price: "10元" },
        { name: "赵阿姨拌饭", price: "10元" },
        { name: "霸王炒鸡拌饭", price: "11元" },
        { name: "土耳其烤肉拌饭", price: "11元" },
        { name: "台湾卤肉拌饭", price: "12元" },
        { name: "小炒五花肉拌饭", price: "12元" },
        { name: "泡菜辣五花肉拌饭", price: "12元" }
      ]
    },
    {
      windowName: "赵阿姨剁椒面",
      foodList: [
        { name: "土豆泥剁椒面 (刀削面/细面)", price: "7元" },
        { name: "西红柿鸡蛋剁椒面 (刀削面/细面)", price: "9元" },
        { name: "手撕鸡剁椒面 (刀削面/细面)", price: "10元" },
        { name: "台湾卤肉剁椒面 (刀削面/细面)", price: "12元" },
        { name: "勾魂肉酱剁椒面 (刀削面/细面)", price: "12元" },
        { name: "湖南小炒肉剁椒面 (刀削面/细面)", price: "12元" },
        { name: "香辣牛肉剁椒面 (刀削面/细面)", price: "12元" }
      ]
    },
    {
      windowName: "东北烤盘饭",
      foodList: [
        { name: "土豆片烤盘饭", price: "10元" },
        { name: "鱼豆腐烤盘饭", price: "10元" },
        { name: "千页豆腐烤盘饭", price: "10元" },
        { name: "豆角土豆片", price: "10元" },
        { name: "五花肉烤盘饭", price: "12元" },
        { name: "梅肉千页豆腐烤盘饭", price: "12元" },
        { name: "酸菜五花肉烤盘饭", price: "12元" },
        { name: "鸡柳土豆片烤盘饭", price: "12元" },
        { name: "鸡蛋火腿烤盘饭", price: "12元" },
        { name: "素炒方便面", price: "8元" },
        { name: "鸡蛋方便面", price: "11元" },
        { name: "五花肉方便面", price: "12元" }
      ]
    },

  {
    windowName: "汉堡炸鸡窗口",
    foodList: []
  }
  ]
},
  // 桔园三楼框架（按桂园格式，无菜谱）
  {
    floorName: "三楼",
    windowList: [
      {
        windowName: "淮南牛肉汤窗口",
        foodList: []
      },
      {
        windowName: "炒饭炒面窗口",
        foodList: []
      },
      {
        windowName: "韩式石锅拌饭窗口",
        foodList: []
      },
      {
        windowName: "汉堡炸鸡窗口",
        foodList: []
      }
    ]
  }
];


export const MEIYUAN_DATA: FloorItem[] = [
  // 待补充
];
