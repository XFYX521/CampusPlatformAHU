// 食堂菜品数据类型定义
export interface FoodItem {
  name: string;
  price: string;
}

export interface WindowItem {
  windowName: string;
  foodList: FoodItem[];
  image?: string; // 窗口图片（可选）
  windowId?: string; // 窗口编号（可选）
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
        windowName: "辣上瘾",
        windowId: "5101",
        image: "Window5101",
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

        windowName: "精品菜",
        windowId: "5102",
        image: "Window5102",
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
        windowName: "精品面点",
        windowId: "5103",
        image: "Window5103",
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
        windowId: "5104",
        image: "Window5104",
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
        windowId: "5105",
        image: "Window5105",
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
        windowId: "5106",
        image: "Window5106",
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
        windowId: "5107",
        image: "Window5107",
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
        windowId: "5108",
        //image: "guiyuan_zaliangbing",
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
        windowId: "5109",
        image: "Window5109",
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
        windowId: "5110",
        image: "Window5110",
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
        windowId: "5111",
        image: "Window5111",
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
        windowName: "塔斯汀",
        windowId: "5201",
        //image: "guiyuan_tasiting",
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
        windowId: "5202",
        image: "Window5202",
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

        windowName: "辣椒炒肉",
        windowId: "5203",
        image: "Window5203",
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
      {

        windowName: "淮南牛肉汤",
        windowId: "5204",
        image: "Window5204",
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
        windowId: "5205",
        image: "Window5205",
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
        windowId: "5206",
        image: "Window5206",
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
        windowId: "5207",
        //image: "guiyuan_axianshaola",
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
        windowId: "5208",
        //image: "guiyuan_teseshuijianbao",
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
        windowId: "5209",
        //image: "guiyuan_chuanshaofan",
        foodList: [
          { name: "鸡排饭", price: "10元" },
          { name: "里脊肉饭", price: "10元" },
          { name: "烤肉饭", price: "12元" },
          { name: "牛排饭", price: "12元" },
          ]
      },
      {
        windowName: "牛伯叔铁锅炖",
        windowId: "5210",
        image: "Window520Window5210",
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
        windowId: "5211",
        image: "Window5211",
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
        windowId: "5212",
        //image: "guiyuan_fuzhuangge",
        foodList: [
          { name: "烤鸭拌饭", price: "12元" },
          ]
      },
      {

        windowName: "超大猪排",
        windowId: "5213",
        //image: "guiyuan_chaodazhupai",
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
        windowId: "5214",
        image: "Window5214",
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

    ]
  },
  // ✅ 新增：桂园三楼（对应本次截图菜单）
  {
    floorName: "三楼",
    windowList: [
      {
        windowName: "SALAD",
        windowId: "5301",
        //image: "guiyuan_salad",
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
        windowId: "5302",
        image: "Window5302",
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
        windowId: "5303",
        //image: "guiyuan_gezhonggaijiaofan",
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
        windowId: "5304",
        image: "Window5304",
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
        windowId: "5305",
        image: "Window5305",
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
        windowId: "5306",
        image: "Window5306",
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
        windowId: "5307",
        image: "Window5307",
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
        windowName: "麻辣烫/香锅/拌",
        windowId: "1101",
        image: "Window1101", // 桔园一楼-麻辣烫
        foodList: [
          { name: "麻辣烫", price: "1.78元/50克" },
          { name: "麻辣烫米饭", price: "" },
          { name: "麻辣烫打包盒", price: "" },
          { name: "麻辣香锅/麻辣拌", price: "1.78元/50克 (荤素同价)" }
        ]
      },

      {
        windowName: "烤鸭饭",
        windowId: "1102",
        image: "Window1102", // 桔园一楼-烤鸭饭
        foodList: [
          { name: "烤鸭饭", price: "12元/份" },
          { name: "烤鸭板", price: "12元/份" },
          { name: "烤鸭半只", price: "20元" },
          { name: "鸭腿", price: "6元/个" },
          { name: "半份菜", price: "5元/半份" }
        ]
      },

      {
        windowName: "精品自选菜",
        windowId: "1103",
        image: "Window1103", // 桔园一楼-自选菜
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
        windowId: "1104",
        image: "Window1104", // 桔园一楼-营养早餐
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
        windowId: "1105",
        image: "Window1105",
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
        windowName: "特色小吃",
        windowId: "1106",
        image: "Window1106",
        foodList: [
          { name: "发面小笼包", price: "6元/笼（7个）" },
          { name: "小笼灌汤包", price: "7元/笼（7个）" },
          { name: "小笼蒸饺", price: "6元/笼（7个）" },
        ]
      },
      {
        windowName: "酱香饼",
        windowId: "1107",
        image: "Window1107", // 桔园一楼-酱香饼
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
        windowId: "1108",
        image: "Window1108", // 桔园一楼-陕行记油泼面
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
        windowId: "1109",
        image: "Window1109", // 桔园一楼-玖昊猪土豆泥拌饭
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
        windowId: "1110",
        image: "Window1110", // 桔园一楼-云南生烫牛肉米线
        foodList: [
          { name: "招牌肉酱米线", price: "9元" },
          { name: "山野泡椒肉酱米线", price: "10元" },
          { name: "川味肉酱拌粉", price: "10元" },
          { name: "公主番茄米线", price: "9元" }
        ]
      },
      {
        windowName: "粗粮渔粉",
        windowId: "1111",
        image: "Window1111", // 桔园一楼-粗粮渔粉
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
        windowId: "1112",
        image: "Window1112", // 桔园一楼-517牛肉蛋炒饭/盖浇饭
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
        windowId: "1113",
        image: "Window1113", // 桔园一楼-申向国鸡柳卷饼
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
        windowId: "1114",
        image: "Window1114", // 桔园一楼-手工馄饨
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
        windowId: "1115",
        image: "Window1115", // 桔园一楼-掉渣饼
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
// 桔园二楼
{
  floorName: "二楼",
  windowList: [
    {
      windowName: "麻辣烫/麻辣香锅",
      windowId: "1201",
      image: "Window1201",
      foodList: [
        { name: "麻辣烫/麻辣香锅/麻辣拌", price: "1.75元/50克" },
        { name: "米饭加0.5元，免费续饭", price: "" },
        { name: "起烫", price: "9.9元起" },
      ]
    },

    {
      windowName: "自选窗口",
      windowId: "1202",
      image: "Window1202",
      foodList: [
        { name: "大锅烧豆腐", price: "按窗口实际标价计价" },
        { name: "秘制红烧肉", price: "按窗口实际标价计价" },
      ]
    },

    {
      windowName: "烤鸭饭",
      windowId: "1203",
      image: "Window1203",
      foodList: [
        { name: "烤鸭饭", price: "12元/份" },
        { name: "特色小菜、鸭头鸭脖、米饭", price: "免费" },
      ]
    },

    {
      windowName: "酸菜煲/椒麻鸡/黑鸭煲",
      windowId: "1204",
      image: "Window1204",
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
      windowName: "四川红油手工水饺/特色盖浇面/汤面",
      windowId: "1205",
      image: "Window1205",
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
      windowId: "1206",
      image: "Window1206",
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
      windowId: "1207",
      image: "Window1207",
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
      windowId: "1208",
      image: "Window1208",
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
      windowName: "咕咕鸡/蹦蹦鸡",
      windowId: "1209",
      image: "Window1209",
      foodList: [
        { name: "咕咕鸡", price: "按实际标价" },
        { name: "蹦蹦鸡", price: "按实际标价" },
      ]
    },
    {
      windowName: "一炉烟火小锅菜/漫食光砂锅菜",
      windowId: "1210",
      image: "Window1210",
      foodList: [
        { name: "一炉烟火小锅菜", price: "按实际标价" },
        { name: "漫食光砂锅菜", price: "按实际标价" },
      ]
    },
    {
      windowName: "重庆肉酱酸辣粉/四川肉酱米粉",
      windowId: "1211",
      image: "Window1211",
      foodList: [
        { name: "重庆肉酱酸辣粉", price: "按实际标价" },
        { name: "四川肉酱米粉", price: "按实际标价" },
      ]
    },
    {
      windowName: "妙言妙语的滑蛋饭",
      windowId: "1212",
      image: "Window1212",
      foodList: [
        { name: "滑蛋饭", price: "按实际标价" },
      ]
    },
  ]
},
  // 桔园三楼框架（按桂园格式，无菜谱）
  {
    floorName: "三楼",
    windowList: [
      {
        windowName: "嗨麦麦汉堡工厂",
        windowId: "1301",
        image: "Window1301",
        foodList: [
          { name: "鸡腿堡套餐A（鸡腿堡+薯条+可乐）", price: "套餐价立省1元" },
          { name: "鸡腿堡套餐B（鸡腿堡+半鸡+可乐）", price: "套餐价立省3元" },
          { name: "鸡腿堡套餐C（鸡腿堡+鸡米花+可乐）", price: "套餐价立省1元" },
          { name: "手枪腿套餐（鸡腿堡+手枪腿+可乐）", price: "套餐价立省3元" }
        ]
      },

      {
        windowName: "湖南小碗菜",
        windowId: "1302",
        image: "Window1302",
        foodList: [
          { name: "红烧冬瓜", price: "2元" },
          { name: "清炒豆芽", price: "2元" },
          { name: "胡萝卜丝", price: "2元" },
          { name: "酸辣土豆丝", price: "2元" },
          { name: "清炒黄瓜", price: "2元" },
          { name: "红枣蒸南瓜", price: "2元" },
          { name: "清炒莴笋丝", price: "2元" },
          { name: "粉丝娃娃菜", price: "2元" },
          { name: "韭菜炒干张", price: "2元" },
          { name: "荷兰豆", price: "3元" },
          { name: "水蒸蛋", price: "3元" },
          { name: "鱼香茄子", price: "3元" },
          { name: "蒸金针菇", price: "3元" },
          { name: "农家豆腐", price: "3元" },
          { name: "麻婆豆腐", price: "3元" },
          { name: "火腿炒蛋", price: "3元" },
          { name: "辣椒炒蛋", price: "3元" },
          { name: "剁辣椒芋头", price: "3元" },
          { name: "香干葱油渣", price: "3元" },
          { name: "蒸辣椒", price: "3元" },
          { name: "玉米粒", price: "3元" },
          { name: "水晶粉丝", price: "3元" },
          { name: "手撕包菜", price: "3元" },
          { name: "芹菜炒肉", price: "4元" },
          { name: "木耳炒肉", price: "4元" },
          { name: "蒜苗炒肉", price: "4元" },
          { name: "笋干炒肉", price: "4元" },
          { name: "白菜炒肉", price: "4元" },
          { name: "外婆菜炒肉", price: "4元" },
          { name: "土豆片炒肉", price: "4元" },
          { name: "青椒脆骨", price: "4元" },
          { name: "农家小炒肉", price: "4元" },
          { name: "雪里红肉沫", price: "4元" },
          { name: "卜豆角炒肉", price: "4元" },
          { name: "长豆角炒肉", price: "4元" },
          { name: "青椒小鱼仔", price: "4元" },
          { name: "肉沫炒青豆", price: "4元" },
          { name: "酸豆角肉沫", price: "4元" },
          { name: "香干回锅肉", price: "4元" },
          { name: "梅菜扣肉", price: "5元" },
          { name: "粉蒸排骨", price: "5元" },
          { name: "红烧鱼块", price: "5元" },
          { name: "粉蒸肉", price: "5元" },
          { name: "腊味合蒸", price: "5元" },
          { name: "老姜炒鸡", price: "5元" },
          { name: "蒸腊鸭", price: "5元" },
          { name: "醋溜鸡", price: "5元" },
          { name: "啤酒鸭", price: "5元" },
          { name: "姜辣凤爪", price: "5元" },
          { name: "小炒牛肉", price: "5元" },
          { name: "红烧肉", price: "5元" },
          { name: "土豆焖牛腩", price: "5元" },
          { name: "土豆烧排骨", price: "5元" },
          { name: "蒜香蒸鸡翅", price: "5元" },
          { name: "剁辣椒蒸鱼块", price: "5元" },
          { name: "腊八豆蒸排骨", price: "5元" },
          { name: "腊八豆蒸香肠", price: "5元" },
          { name: "腊八豆蒸腊肉", price: "5元" },
          { name: "玉米骨头汤", price: "5元" },
          { name: "农家鸡汤", price: "5元" },
          { name: "鸽子汤", price: "5元" },
          { name: "海带排骨汤", price: "5元" }
        ]
      },

      {
        windowName: "牛肉拉面&拌面",
        windowId: "1303",
        image: "Window1303",
        foodList: [
          { name: "红烧牛肉拉面/拌面", price: "12元" },
          { name: "白切牛肉拉面/拌面", price: "12元" },
          { name: "酸菜牛肉拉面/拌面", price: "12元" },
          { name: "土豆牛肉拉面/拌面", price: "12元" },
          { name: "牛肉粉丝", price: "12元" },
          { name: "鸡腿拉面/拌面", price: "11元" },
          { name: "奥尔良鸡块拉面/拌面", price: "11元" },
          { name: "香干肉丝拉面/拌面", price: "10元" },
          { name: "土豆肉丝拉面/拌面", price: "10元" },
          { name: "酱香拌面", price: "9元" },
          { name: "孜然藤椒拌面", price: "9元" },
          { name: "孜然拌面", price: "9元" },
          { name: "麻酱拌面", price: "9元" },
          { name: "西红柿鸡蛋拉面/拌面", price: "9元" },
          { name: "鸡蛋拉面/拌面", price: "7元" },
          { name: "素汤拉面/拌面", price: "6元" }
        ]
      },

      {
        windowName: "重庆小面",
        windowId: "1304",
        image: "Window1304",
        foodList: [
          { name: "红烧牛肉面", price: "7~12" },
          { name: "红烧排骨面", price: "7~12" },
          { name: "香辣牛杂面", price: "7~12" },
          { name: "酸菜牛肉面", price: "7~12" },
          { name: "泡椒鸡杂面", price: "7~12" },
          { name: "担担面", price: "7~12" },
          { name: "牛肉酸辣粉", price: "7~12" },
          { name: "成都姜鸭面", price: "7~12" },
          { name: "酸菜骨汤面", price: "7~12" },
          { name: "青菜骨汤面", price: "7~12" },
          { name: "西红柿鸡蛋面", price: "7~12" },
          { name: "红烧牛肉拌面", price: "8~12" },
          { name: "红烧排骨拌面", price: "8~12" },
          { name: "肉酱葱油拌面", price: "8~12" },
          { name: "泡椒鸡杂拌面", price: "8~12" },
          { name: "宜宾燃面", price: "8~12" },
          { name: "成都姜鸭拌面", price: "8~12" },
          { name: "辣子鸡干拌面", price: "8~12" },
          { name: "肉酱干拌面", price: "8~12" },
          { name: "葱油拌面", price: "8~12" },
          { name: "西红柿鸡蛋拌面", price: "8~12" },
          { name: "牛肉水饺", price: "10~11" },
          { name: "猪肉白菜水饺", price: "10~11" }
        ]
      },

      {
        windowName: "油泼面&炸串",
        windowId: "1305",
        image: "Window1305",
        foodList: [
          { name: "基础油泼面", price: "6元" },
          { name: "油泼面+香肠/五香蛋", price: "7.5元" },
          { name: "油泼面+花干/酸菜", price: "8元" },
          { name: "油泼面+炸蛋/酸菜肉丝/西红柿鸡蛋/肉酱", price: "9~10元" },
          { name: "油泼面+香菇鸡/鸡杂/辣子鸡", price: "12元" }
        ]
      },

      {
        windowName: "扬州炒饭炒粉",
        windowId: "1306",
        image: "Window1306",
        foodList: [
          { name: "蛋炒饭", price: "7元" },
          { name: "茄汁蛋炒饭", price: "8元" },
          { name: "青椒蛋炒饭", price: "8元" },
          { name: "酸菜蛋炒饭", price: "8元" },
          { name: "火腿肠炒饭", price: "9元" },
          { name: "酸菜火腿炒饭", price: "9元" },
          { name: "茄汁火腿炒饭", price: "9元" },
          { name: "肉丝炒饭", price: "9元" },
          { name: "腊肉炒饭", price: "10元" },
          { name: "酸菜肉丝炒饭", price: "10元" },
          { name: "青椒肉丝炒饭", price: "10元" },
          { name: "老干妈肉丝炒饭", price: "10元" },
          { name: "腊肉蛋炒饭", price: "11元" },
          { name: "回锅肉炒饭", price: "11元" },
          { name: "酸菜肉卷炒饭", price: "11元" },
          { name: "三鲜炒饭", price: "12元" },
          { name: "扬州炒饭", price: "12元" },
          { name: "鱿鱼炒饭", price: "12元" },
          { name: "外婆菜炒饭", price: "12元" },
          { name: "老干妈鱿鱼", price: "12元" },
          { name: "蛋炒面/河粉", price: "8元" },
          { name: "肉卷炒面", price: "9元" },
          { name: "茄汁炒面", price: "9元" },
          { name: "火腿肠炒面", price: "9元" },
          { name: "老干妈肉丝炒面", price: "10元" },
          { name: "鱿鱼炒面", price: "10元" },
          { name: "肉丝炒面/河粉", price: "11元" },
          { name: "老干妈鱿鱼炒面", price: "12元" },
          { name: "三鲜炒面/河粉", price: "12元" }
        ]
      },

      {
        windowName: "汤面葱油拌面专区",
        windowId: "1307",
        image: "Window1307",
        foodList: [
          { name: "红烧牛肉", price: "12元" },
          { name: "红烧牛杂", price: "12元" },
          { name: "香菇鸡", price: "12元" },
          { name: "鸡腿", price: "12元" },
          { name: "小酥肉", price: "12元" },
          { name: "香辣鸡杂", price: "12元" },
          { name: "小炒牛肉", price: "12元" },
          { name: "泡椒鸡胗", price: "12元" },
          { name: "农家一碗香 (汤面/拌面)", price: "12元" },
          { name: "番茄鸡蛋汤面", price: "9元" },
          { name: "番茄鸡蛋拌面", price: "9元" },
          { name: "青菜牛骨汤面", price: "7元" },
          { name: "麻酱鸡丝拌面", price: "10元" },
          { name: "咸蛋黄拌面", price: "8元" },
          { name: "韩式火鸡面", price: "8元" },
          { name: "葱油拌面", price: "8元" },
          { name: "牛肉香辣粉", price: "11.8元" },
          { name: "柳州螺蛳粉", price: "11.8元" },
          { name: "牛肉水饺", price: "9.9元" }
        ]
      },

      {
        windowName: "螺蛳粉&麻辣香锅",
        windowId: "1308",
        image: "Window1308",
        foodList: [
          { name: "原味螺蛳粉", price: "11.8元" },
          { name: "干捞螺蛳粉", price: "11.8元" },
          { name: "炸蛋", price: "3元" },
          { name: "响铃卷", price: "2元" },
          { name: "鸭爪", price: "3.5元" },
          { name: "鸡爪", price: "3.5元" },
          { name: "卤肉肠", price: "2元" },
          { name: "卤鸡腿", price: "5元" },
          { name: "煎蛋", price: "1.5元" }
        ]
      }
    ]
  }
];


export const MEIYUAN_DATA: FloorItem[] = [
  // 梅园一楼
  {
    floorName: "一楼",
    windowList: [
      {
        windowName: "贵州花溪米线面条",
        windowId: "2101",
        image: "Window2101",
        foodList: [
          { name: "招牌肉酱米线/面", price: "9元" },
          { name: "山野泡椒米线/面", price: "10元" },
          { name: "香辣鸡杂米线/面", price: "10元" },
          { name: "红烧牛肉米线/面", price: "12元" },
          { name: "番茄汤米线/面", price: "9元" },
          { name: "百香果米线/面", price: "10元" },
          { name: "雪菜肉丝米线/面", price: "10元" },
          { name: "香辣鸡丝米线/面", price: "11元" },
          { name: "肉酱拌米线/面", price: "9元" },
          { name: "山野泡椒拌米线/面", price: "10元" },
          { name: "咸蛋黄拌米线/面", price: "9元" },
          { name: "葱油拌米线/面", price: "9元" },
          { name: "蟹黄拌米线/面", price: "9元" },
          { name: "椒麻拌米线/面", price: "9元" },
          { name: "雪菜肉丝拌米线/面", price: "10元" },
          { name: "香辣鸡丝拌米线/面", price: "11元" },
          { name: "鸡腿", price: "6元/个、9.9元/2个" },
          { name: "鸡肉条", price: "12元/份" },
          { name: "香骨鸡", price: "10元/份" },
          { name: "蟹排", price: "10元/份" },
          { name: "地瓜丸", price: "10元/份" },
          { name: "炸蘑菇", price: "10元/份" },
          { name: "鸡翅", price: "4元/个、10元/3个" },
          { name: "翅根", price: "4元/个、10元/3个" }
        ]
      },
      {
        windowName: "麻辣拌&麻辣烫",
        windowId: "2102",
        image: "Window1201",
        foodList: [
          { name: "麻辣烫/麻辣香锅/麻辣拌", price: "1.75元/50克" },
          { name: "米饭加0.5元，免费续饭", price: "" },
          { name: "起烫", price: "9.9元起" },// 待补充具体菜品数据
        ]
      },
      {
        windowName: "稻香鸭腿饭",
        windowId: "2103",
        image: "Window2103",
        foodList: [
          { name: "招牌鸭腿饭", price: "12元" },
          { name: "猪脚肘子饭", price: "12元" },
          { name: "特色鸭肠饭", price: "12元" },
          { name: "精品鸡排饭", price: "11元" },
          { name: "精品鸡腿饭", price: "10元" },
          { name: "特色丸子饭", price: "10元" },
          { name: "肘子拼鸡排", price: "12元" },
          { name: "鸭肠拼鸡排", price: "12元" },
          { name: "肘子拼鸭肠", price: "12元" },
          { name: "鸡腿", price: "5元/个" },
          { name: "丸子", price: "5元/份" },
          { name: "鸭锁骨", price: "3元/个" },
          { name: "鸭心", price: "2元/5个" },
          { name: "豆干", price: "1元/片" },
          { name: "啵啵肠", price: "1元/个" },
          { name: "藕片", price: "1.5元/2片" }
        ]
      },
      {
        windowName: "黑金卤肉咖喱猪排饭",
        windowId: "2104",
        image: "Window2104",
        foodList: [
          { name: "招牌卤肉饭", price: "11元" },
          { name: "黑椒鸡排饭", price: "11元" },
          { name: "原切猪排咖喱饭(小份)", price: "12元" },
          { name: "孜然烤肉咖喱饭", price: "11元" },
          { name: "可乐鸡咖喱饭", price: "11元" },
          { name: "尊享鸡排咖喱饭", price: "11元" },
          { name: "经典炸鸡咖喱饭", price: "11元" },
          { name: "原切猪排加料", price: "3元" }
        ]
      },
      {
        windowName: "朱家小馆羊杂面",
        windowId: "2105",
        image: "Window2105",
        foodList: [
          { name: "特色羊杂面", price: "11元" },
          { name: "招牌拌面", price: "12元" },
          { name: "招牌烤拌面", price: "10元" },
          { name: "麻辣汤面", price: "8元" },
          { name: "酸辣面", price: "8元" },
          { name: "卤肉面", price: "11元" },
          { name: "酸豆角豆角面", price: "9元" },
          { name: "鸡蛋烤拌面", price: "9元" },
          { name: "麻香鸡丝拌面", price: "10元" },
          { name: "酸豆角拌面", price: "9元" },
          { name: "肉燥拌面", price: "9元" },
          { name: "混合炸酱面", price: "10元" },
          { name: "肠、煎蛋、卤豆干、卤肠、卤鸡胗、卤鸡腿", price: "2~5元" }
        ]
      },
      {
        windowName: "瓦香鸡米饭",
        windowId: "2106",
        image: "Window2106",
        foodList: [
          { name: "瓦香包菜", price: "8元/份" },
          { name: "瓦香花菜", price: "8元/份" },
          { name: "瓦香土豆", price: "10元/份" },
          { name: "瓦香年糕", price: "12元/份" },
          { name: "瓦香手撕面筋", price: "12元/份" },
          { name: "瓦香小酥肉", price: "12元/份" },
          { name: "瓦香锅包肉", price: "12元/份" },
          { name: "瓦香鸡米饭", price: "12元/份" },
          { name: "包菜", price: "1元" },
          { name: "花菜", price: "1元" },
          { name: "年糕", price: "2元" },
          { name: "面筋", price: "2元" },
          { name: "土豆", price: "2元" },
          { name: "鸡肉（40g）", price: "4元" }
        ]
      },
      {
        windowName: "明厨优选",
        windowId: "2107",
        image: "Window2107",
        foodList: [
          { name: "紫米饭", price: "0.5元/份" },
          { name: "白馒头", price: "0.5元/个" },
          { name: "荤菜+素菜+豆干", price: "10~12元" }
        ]
      },
      {
        windowName: "广式烧腊饭",
        windowId: "2108",
        image: "Window2108",
        foodList: [
          { name: "金牌烧鸭饭+蒸蛋+素菜+豆干", price: "11元" },
          { name: "蜜汁鸡腿饭+蒸蛋+素菜+豆干", price: "11元" },
          { name: "蜜汁叉烧饭+蒸蛋+素菜+豆干", price: "12元" },
          { name: "蜜汁鸡翅饭+蒸蛋+素菜+豆干", price: "12元" },
          { name: "隆江猪脚饭+蒸蛋+素菜+豆干", price: "12元" },
          { name: "美葱白切鸡饭+蒸蛋+素菜+豆干", price: "11元" },
          { name: "东江手撕鸡饭+蒸蛋+素菜+豆干", price: "10元" },
          { name: "吊烧鸭腿饭+蒸蛋+素菜+豆干", price: "12元" },
          { name: "黑椒鸡扒饭+蒸蛋+素菜+豆干", price: "10元" },
          { name: "脆皮鸭腿饭+蒸蛋+素菜+豆干", price: "11元" },
          { name: "白切鸡腿饭+蒸蛋+素菜+豆干", price: "11元" },
          { name: "卤水鸡腿饭+蒸蛋+素菜+豆干", price: "11元" },
          { name: "潮汕肉卷饭+蒸蛋+素菜+豆干", price: "10元" },
          { name: "红油猪耳饭+蒸蛋+素菜+豆干", price: "12元" },
          { name: "脆皮烧肉饭+蒸蛋+素菜+豆干", price: "12元" },
          { name: "卤水油鸡饭+蒸蛋+素菜+豆干", price: "11元" },
          { name: "白切鸡", price: "3元/份" },
          { name: "叉烧", price: "3元/份" },
          { name: "手撕鸡", price: "3元/份" },
          { name: "烧鸭", price: "3元/份" }
        ]
      },
      {
        windowName: "精品快餐",
        windowId: "2109",
        image: "Window2109",
        foodList: [
          { name: "紫米饭", price: "0.5元" },// 待补充具体菜品数据
        ]
      },
      {
        windowName: "手工鲜包",
        windowId: "2110",
        image: "Window2110",
        foodList: [
          { name: "青菜包", price: "1.2元" },
          { name: "鲜肉包", price: "1.5元" },
          { name: "梅干菜包", price: "1.5元" },
          { name: "鸡腿包", price: "1.5元" },
          { name: "茄子包", price: "1.5元" },
          { name: "麻香鸡腿包", price: "1.5元" },
          { name: "卤肉包", price: "2元" },
          { name: "面包", price: "2元" },
          { name: "小笼包", price: "6元/笼" },
          { name: "杨枝甘露包", price: "1.5~3.5元" },
          { name: "粉丝煎饺", price: "1.5~3.5元" },
          { name: "烧麦", price: "1.5~3.5元" },
          { name: "糯米粑", price: "1.5~3.5元" },
          { name: "玉米蒸饺", price: "1.5~3.5元" },
          { name: "玉米鲜肉饼", price: "1.5~3.5元" },
          { name: "南瓜发糕", price: "1.5~3.5元" },
          { name: "玉米热狗卷", price: "1.5~3.5元" },
          { name: "糯米鸡", price: "1.5~3.5元" },
          { name: "海苔饭团", price: "1.5~3.5元" },
          { name: "豆浆", price: "1.8~2.5元" },
          { name: "银耳汤", price: "1.8~2.5元" },
          { name: "绿豆沙", price: "1.8~2.5元" },
          { name: "红枣豆浆", price: "1.8~2.5元" },
          { name: "黑米粥", price: "2~2.5元" },
          { name: "八宝粥", price: "2~2.5元" },
          { name: "牛奶燕麦粥", price: "2~2.5元" },
          { name: "小米南瓜粥", price: "2~2.5元" }
        ]
      },
      {
        windowName: "土豆泥拌饭",
        windowId: "2111",
        image: "Window2111",
        foodList: [
          { name: "可乐鸡", price: "12元" },
          { name: "糖醋鸡丁", price: "12元" },
          { name: "咖喱鸡", price: "12元" },
          { name: "黑椒肉柳", price: "12元" },
          { name: "下饭辣椒炒肉", price: "12元" },
          { name: "藤椒酸菜鱼丸", price: "11~12元" },
          { name: "灶香卤肉", price: "11~12元" },
          { name: "辣子鸡丁", price: "11~12元" },
          { name: "土匪黑鸭", price: "11~12元" },
          { name: "黑椒鸡丁", price: "11~12元" },
          { name: "麻香肉沫豆腐", price: "9~12元" },
          { name: "鱼香肉丝", price: "9~12元" },
          { name: "招牌半只鸡", price: "9~12元" },
          { name: "飘香鸭腿", price: "9~12元" },
          { name: "鲜香鸡腿", price: "9~12元" }
        ]
      },
      {
        windowName: "千里香馄饨",
        windowId: "2112",
        image: "Window2112",
        foodList: [
          { name: "鲜肉小馄饨小份", price: "6.5元/20只" },
          { name: "鲜肉小馄饨大份", price: "8.5元/30只" },
          { name: "海苔肉小馄饨小份", price: "7.5元/20只" },
          { name: "海苔肉小馄饨大份", price: "9.5元/30只" },
          { name: "蟹黄肉小馄饨小份", price: "8.5元/20只" },
          { name: "蟹黄肉小馄饨大份", price: "11元/30只" },
          { name: "鲜肉大馄饨小份", price: "10元/9只" },
          { name: "鲜肉大馄饨大份", price: "12元/11只" },
          { name: "荠菜肉大馄饨小份", price: "10元/9只" },
          { name: "荠菜肉大馄饨大份", price: "12元/11只" },
          { name: "香菇肉大馄饨小份", price: "10~12元/9只" },
          { name: "香菇肉大馄饨大份", price: "12元/11只" },
          { name: "韭菜肉大馄饨小份", price: "10~12元/9只" },
          { name: "韭菜肉大馄饨大份", price: "12元/11只" },
          { name: "玉米肉大馄饨小份", price: "10~12元/9只" },
          { name: "玉米肉大馄饨大份", price: "12元/11只" },
          { name: "虾仁肉大馄饨小份", price: "10~12元/9只" },
          { name: "虾仁肉大馄饨大份", price: "12元/11只" },
          { name: "蟹黄肉大馄饨小份", price: "10~12元/9只" },
          { name: "蟹黄肉大馄饨大份", price: "12元/11只" },
          { name: "自选水饺", price: "1.65元/两" }
        ]
      }
    ]
  },
  // 梅园二楼
  {
    floorName: "二楼",
    windowList: [
      {
        windowName: "稻香捞面",
        windowId: "2201",
        image: "Window2201",
        foodList: [
          { name: "皖北拌面", price: "17.5元/份" },
          { name: "虎皮鸡蛋", price: "1元/个" },
          { name: "秘制卤干", price: "1元/个" },
          { name: "纯肉烤肠", price: "3元/根" },
          { name: "兰花干", price: "2元/块" }
        ]
      },
      {
        windowName: "南昌瓦罐汤",
        windowId: "2202",
        image: "Window2202",
        foodList: [
          { name: "鸡蛋肉饼汤", price: "5元/份" },
          { name: "皮蛋肉饼汤", price: "5元/份" },
          { name: "墨鱼肉饼汤", price: "5元/份" },
          { name: "海带排骨汤", price: "5元/份" },
          { name: "香菇母鸡汤", price: "5元/份" },
          { name: "茶树菇肉饼汤", price: "5元/份" },
          { name: "玉米排骨汤", price: "5元/份" }
        ]
      },
      {
        windowName: "徽州家常菜",
        windowId: "2203",
        image: "Window2203",
        foodList: [
          { name: "山药木耳", price: "3.5元/份" },
          { name: "茄子豆角", price: "3.5元/份" },
          { name: "小炒藕片", price: "3.5元/份" },
          { name: "丝瓜毛豆", price: "3.5元/份" },
          { name: "蒜泥西兰花", price: "4元/份" },
          { name: "香辣腐竹", price: "4元/份" },
          { name: "青椒肉片", price: "4元/份" },
          { name: "土豆肉片", price: "4元/份" },
          { name: "毛豆烧鸡", price: "4.5元/份" },
          { name: "葱油鸡", price: "4.5元/份" },
          { name: "宫爆鸡丁", price: "4.5元/份" },
          { name: "鱼香肉丝", price: "4.5元/份" },
          { name: "红烧大排", price: "5元/份" },
          { name: "椒麻鸡腿", price: "5元/份" },
          { name: "干锅鸭腿", price: "5元/份" },
          { name: "椒盐大虾", price: "5元/份" },
          { name: "糖醋鱼片", price: "5元/份" },
          { name: "土豆烧牛肉", price: "5元/份" },
          { name: "特色红烧肉", price: "5元/份" },
          { name: "炒茄子肉丝", price: "5元/份" }
        ]
      },
      {
        windowName: "徽州咸肉饭",
        windowId: "2204",
        image: "Window2204",
        foodList: [
          { name: "基础套餐小菜+菜饭", price: "7元" },
          { name: "基础套餐两素+菜饭", price: "9元" },
          { name: "荤菜套餐两素+荤菜+米饭", price: "12元" }
        ]
      },
      {
        windowName: "橘生南淮南牛肉汤",
        windowId: "2205",
        image: "Window2205",
        foodList: [
          { name: "淮南牛肉汤", price: "12元/碗" },
          { name: "鲜吊龙牛肉汤", price: "12元/碗" },
          { name: "牛肉米线汤", price: "12元/碗" },
          { name: "烧饼", price: "1.5元/个" },
          { name: "鱼豆腐", price: "1元/2个" },
          { name: "牛肉丸", price: "1元/1个" },
          { name: "鹌鹑蛋", price: "1.5元/2个" },
          { name: "鲜牛肉", price: "5元/50g" }
        ]
      },
      {
        windowName: "新潮双拼饭",
        windowId: "2206",
        image: "Window2206",
        foodList: [
          { name: "鲜牛肉双拼盖饭", price: "暂未标价" }
        ]
      },
      {
        windowName: "吊炉烤肉饭",
        windowId: "2207",
        image: "Window2207",
        foodList: [
          { name: "吊炉烤鸡饭", price: "12元/份" },
          { name: "烤肉饭", price: "12元/份" },
          { name: "烧鸭饭", price: "12元/份" },
          { name: "大肉饭", price: "12元/份" },
          { name: "叉烧饭", price: "12元/份" },
          { name: "鸭肠饭", price: "12元/份" },
          { name: "烤肠", price: "12元/单点" },
          { name: "叉烧小肋排", price: "12元/单点" },
          { name: "脱骨鸡", price: "12元/单点" },
          { name: "夫妻肺片", price: "12元/单点" },
          { name: "鸭全翅", price: "4元" },
          { name: "红油鸭肠", price: "9元" },
          { name: "红油猪耳", price: "12元" },
          { name: "肉汁荷包蛋", price: "1元/个" }
        ]
      },
      {
        windowName: "蘸水牛肉菜",
        windowId: "2208",
        image: "Window2208",
        foodList: [
          { name: "7种时蔬+蘸水+米饭", price: "9元/份" },
          { name: "轻腌鸡胸肉", price: "3.5元/两" },
          { name: "鲜嫩里脊", price: "3.5元/两" },
          { name: "鲜弹大虾", price: "3.5元/两" },
          { name: "大刀牛肉", price: "5元/两" },
          { name: "牛肉拼鸡胸肉", price: "5元/两" },
          { name: "牛肉拼里脊", price: "5元/两" }
        ]
      },
      {
        windowName: "螺鼎记螺蛳粉",
        windowId: "2209",
        image: "Window2209",
        foodList: [
          { name: "招牌螺蛳粉", price: "12元/份" },
          { name: "炸蛋、卤蛋、豆腐干、卤干", price: "1元/份" },
          { name: "豆腐果", price: "1元/3个" },
          { name: "花干、生菜、酸笋、豆角、腐竹", price: "3元/份" },
          { name: "鸡爪", price: "3.5元/只" },
          { name: "鸭爪、鸭翅、腊肠", price: "3元/只" },
          { name: "猪脚", price: "9.9元/只" }
        ]
      },
      {
        windowName: "川渝水煮菜",
        windowId: "2210",
        image: "Window2210",
        foodList: [
          { name: "豆腐火腿", price: "9元/份" },
          { name: "鸭血火腿", price: "9元/份" },
          { name: "鸭血土豆", price: "9元/份" },
          { name: "鸭血培根", price: "9元/份" },
          { name: "豆腐鸭血", price: "9元/份" },
          { name: "鸡片鸭血", price: "9元/份" },
          { name: "酥肉年糕", price: "9元/份" },
          { name: "土豆片土豆", price: "9元/份" },
          { name: "鸡片豆腐", price: "12元/份" },
          { name: "鸭血酥肉", price: "12元/份" },
          { name: "青椒毛豆肉丝", price: "12元/份" },
          { name: "鱼香肉丝", price: "12元/份" },
          { name: "回锅肉", price: "12元/份" },
          { name: "土豆鸡块", price: "12元/份" },
          { name: "三鲜鸭血", price: "10元/份" },
          { name: "其他菜品", price: "8元/份" }
        ]
      },
      {
        windowName: "匠心卤热卤拌饭",
        windowId: "2211",
        image: "Window2211",
        foodList: [
          { name: "卤汁海带饭", price: "8元" },
          { name: "卤汁莲藕饭", price: "9元" },
          { name: "蒜香茄子饭", price: "9元" },
          { name: "辣卤腐竹饭", price: "9元" },
          { name: "孜然土豆饭", price: "9元" },
          { name: "卤汁肉肠饭", price: "10元" },
          { name: "卤香鸭腿饭", price: "11元" },
          { name: "甜辣鸭翅饭", price: "11元" },
          { name: "椒麻鸭肠饭", price: "11元" },
          { name: "脆笋肉丝饭", price: "12元" },
          { name: "卤汁肉卷饭", price: "12元" },
          { name: "青椒肉丝饭", price: "12元" },
          { name: "卤香鸡腿", price: "4元/份" },
          { name: "武汉黑鸭", price: "4元/份" },
          { name: "超级卤肉", price: "4元/份" },
          { name: "金牌肘子", price: "5元/份" },
          { name: "鲜椒牛肉", price: "5元/份" }
        ]
      },
      {
        windowName: "武汉黑鸭",
        windowId: "2212",
        image: "Window2212",
        foodList: [
          { name: "麻辣黑鸭系列卤菜", price: "暂未标价" }
        ]
      },
      {
        windowName: "杨国福麻辣烫",
        windowId: "2213",
        image: "Window2213",
        foodList: [
          { name: "荤素各类食材", price: "1.86元/50g" }
        ]
      },
      {
        windowName: "甲味轩",
        windowId: "2214",
        image: "Window2214",
        foodList: [
          { name: "水饺小份(12个)", price: "7元" },
          { name: "水饺中份(18个)", price: "10元" },
          { name: "水饺大份(22个)", price: "12元" },
          { name: "馄饨小份(12个)", price: "10元" },
          { name: "馄饨大份(15个)", price: "12元" },
          { name: "汤圆小份(6个)", price: "6元" },
          { name: "汤圆中份(10个+赠送1个)", price: "10元" },
          { name: "汤圆大份(12个+赠送2个)", price: "12元" },
          { name: "水饺、馄饨、汤圆散称", price: "1.98元/两" }
        ]
      }
    ]
  },
  // 梅园三楼
  {
    floorName: "三楼",
    windowList: [
      {
        windowName: "堡Q弹",
        windowId: "2301",
        image: "Window2301",
        foodList: [
          { name: "A1两件套 (汉堡+可乐)", price: "11元" },
          { name: "A2两件套 (鸡腿堡+可乐)", price: "11元" },
          { name: "B1三件套", price: "13.8元" },
          { name: "B2三件套", price: "14元" },
          { name: "B3三件套", price: "14元" },
          { name: "B4三件套", price: "16.8元" },
          { name: "C1四件套", price: "17元" },
          { name: "C2四件套", price: "18.8元" },
          { name: "C3四件套", price: "19元" },
          { name: "C4四件套", price: "19元" },
          { name: "E1堡垒餐 (汉堡+鸡肉卷+可乐)", price: "17元" },
          { name: "E2堡垒餐 (双汉堡+可乐)", price: "18元" },
          { name: "E3堡垒餐", price: "20元" },
          { name: "E4小食全家桶套餐", price: "18.8元" },
          { name: "S1欢乐小食餐", price: "12元" },
          { name: "S2欢乐小食餐", price: "13元" },
          { name: "S3欢乐小食餐", price: "14元" },
          { name: "好事成双双汉堡", price: "13元" },
          { name: "快乐单人餐 (汉堡+鸡块+可乐)", price: "14元" },
          { name: "F1双人套餐", price: "28元" },
          { name: "F2双人套餐", price: "30元" },
          { name: "F3双人套餐", price: "31元" },
          { name: "F4双人套餐", price: "33元" },
          { name: "老北京鸡肉卷", price: "7元" },
          { name: "招牌香辣汉堡", price: "8元" },
          { name: "培根煎蛋汉堡", price: "10元" },
          { name: "多汁牛肉汉堡", price: "10元" },
          { name: "板烧鸡腿汉堡", price: "10元" },
          { name: "霸王大肉串×2", price: "4元" },
          { name: "玉米条", price: "4元" },
          { name: "上校鸡块", price: "5元" },
          { name: "藤椒鸡肉条×3", price: "5元" },
          { name: "盐酥鸡米花", price: "7元" },
          { name: "厚切粗薯", price: "7元" },
          { name: "香辣翅尖", price: "7元" },
          { name: "黄金鸡柳", price: "7元" },
          { name: "脆皮鸡腿", price: "8元" },
          { name: "地瓜丸×5个", price: "4元" },
          { name: "手枪腿", price: "12元" },
          { name: "藤椒半边鸡", price: "12元" },
          { name: "冰柠可乐", price: "4元" },
          { name: "冰柠七喜", price: "4元" },
          { name: "咖啡", price: "6元" },
          { name: "牛奶", price: "6元" }
        ]
      },
      {
        windowName: "兰州拉面",
        windowId: "2302",
        image: "Window2302",
        foodList: [
          { name: "兰州拉面", price: "9元" },
          { name: "鸡蛋刀削面", price: "8元" },
          { name: "青菜拉面", price: "8元" },
          { name: "鸡蛋拉面", price: "8元" },
          { name: "牛肉刀削面", price: "9元" },
          { name: "番茄牛肉面", price: "12元" },
          { name: "红烧牛肉拉面", price: "12元" },
          { name: "酸菜牛肉拉面", price: "12元" },
          { name: "笋尖牛肉面", price: "12元" },
          { name: "牛肉水饺", price: "12元" },
          { name: "牛肉泡馍", price: "12元" },
          { name: "青椒土豆丝拌面", price: "10元" },
          { name: "西红柿鸡蛋拌面/饭", price: "11元" },
          { name: "土豆牛肉拌面/饭", price: "12元" },
          { name: "蘑菇炒肉拌面/饭", price: "12元" },
          { name: "孜然牛肉拌面/饭", price: "12元" },
          { name: "青椒牛肉拌面/饭", price: "12元" },
          { name: "葱爆牛肉拌面/饭", price: "12元" },
          { name: "大盘鸡拌面/饭", price: "12元" },
          { name: "牛肉烩面", price: "12元" },
          { name: "过油肉拌面", price: "12元" },
          { name: "红烧鸡块盖面/饭", price: "12元" },
          { name: "土豆鸡块盖面/饭", price: "12元" },
          { name: "鸡蛋炒拉面", price: "11元" },
          { name: "牛肉炒拉面", price: "12元" },
          { name: "牛肉刀削炒面", price: "12元" },
          { name: "鸡蛋刀削炒面", price: "11元" },
          { name: "西红柿鸡蛋刀削面", price: "11元" },
          { name: "干煸炒面", price: "12元" },
          { name: "蛋炒饭", price: "9元" },
          { name: "牛肉炒饭", price: "10元" },
          { name: "兰州炒饭", price: "12元" },
          { name: "孜然牛肉炒饭", price: "12元" },
          { name: "笋尖牛肉炒饭", price: "12元" },
          { name: "酸菜牛肉炒饭", price: "12元" },
          { name: "鸡蛋炒饼", price: "11元" },
          { name: "牛肉炒饼", price: "12元" },
          { name: "煎蛋", price: "1元" },
          { name: "兰花干", price: "3元" },
          { name: "牛肉丸子", price: "3元" },
          { name: "面筋", price: "3元" },
          { name: "油炸饼", price: "3元" },
          { name: "肉夹馍", price: "8元" },
          { name: "牛肉（一份）", price: "8元" },
          { name: "A套餐", price: "12元" },
          { name: "B套餐", price: "18元" },
          { name: "C套餐", price: "15元" },
          { name: "D套餐", price: "15元" },
          { name: "A1套餐", price: "18元" },
          { name: "A2套餐", price: "19元" },
          { name: "A3套餐", price: "15元" },
          { name: "A4套餐", price: "20元" },
          { name: "A5套餐", price: "19元" }
        ]
      },
      {
        windowName: "淮北烫面",
        windowId: "2303",
        image: "Window2303",
        foodList: [
          { name: "原味烫面", price: "8元" },
          { name: "羊油烫面", price: "11元" },
          { name: "肉酱烫面", price: "12元" },
          { name: "羊油+肉酱烫面", price: "12元" },
          { name: "干拌烫面", price: "7元" },
          { name: "卤蛋", price: "1元" },
          { name: "花干", price: "2元" },
          { name: "油条", price: "2元" },
          { name: "香肠 (2根)", price: "3元" }
        ]
      },
      {
        windowName: "闽南小馆",
        windowId: "2304",
        image: "Window2304",
        foodList: [
          { name: "黑金卤肉饭", price: "9.9元" },
          { name: "黑金卤肉拌面", price: "9.9元" },
          { name: "椰香咖喱芝士鸡排饭", price: "9.9元" },
          { name: "椰香咖喱黄金猪排饭", price: "9.9元" },
          { name: "话梅排骨饭", price: "9.9元" },
          { name: "红烧牛杂饭/面/粉", price: "9.9元" },
          { name: "百香果酸汤鸡肉饭", price: "9.9元" },
          { name: "闽南咸饭", price: "9.9元" },
          { name: "三拼饭 (卤肉+百香果+咖喱)", price: "9.9元" },
          { name: "泰式冬阴功米粉", price: "9.9元" },
          { name: "泰式冬阴功面", price: "9.9元" },
          { name: "卤蛋", price: "9.9元" },
          { name: "卤豆干", price: "9.9元" },
          { name: "荷包蛋", price: "9.9元" },
          { name: "牛杂", price: "9.9元" },
          { name: "南美对虾", price: "9.9元" },
          { name: "芝士鸡排", price: "9.9元" },
          { name: "猪排", price: "9.9元" }
        ]
      },
      {
        windowName: "锦康风味",
        windowId: "2305",
        image: "Window2305",
        foodList: [
          { name: "锦康特色风味·米糍甜品", price: "3元" },
          { name: "芝麻米糍", price: "4元" },
          { name: "红豆米糍", price: "4元" },
          { name: "紫米米糍", price: "4元" },
          { name: "芋泥米糍", price: "6元" },
          { name: "芋泥红豆双拼", price: "6元" },
          { name: "芋泥紫米双拼", price: "6元" },
          { name: "红豆奶酪双拼", price: "6元" },
          { name: "紫米肉松双拼", price: "6元" },
          { name: "芋泥奥利奥双拼", price: "7元" },
          { name: "芋泥奶酪双拼", price: "7元" },
          { name: "紫米奶酪双拼", price: "6元" },
          { name: "蛋黄肉松双拼", price: "7元" },
          { name: "芋泥蛋黄肉松三拼", price: "8元" },
          { name: "芋泥奥利奥奶酪三拼", price: "8元" },
          { name: "芋泥紫米奶酪三拼", price: "8元" },
          { name: "锦康风味紫米蛋黄肉松三拼", price: "8元" },
          { name: "红豆", price: "1元" },
          { name: "芋泥", price: "2元" },
          { name: "芝麻", price: "1元" },
          { name: "肉松", price: "2元" },
          { name: "紫米", price: "1元" },
          { name: "蛋黄", price: "2元" },
          { name: "奥利奥", price: "2元" },
          { name: "奶酪", price: "2元" },
          { name: "芋泥奶酪球", price: "10元" },
          { name: "芋泥奶酪盖砖", price: "10元" },
          { name: "芋泥奶酪盒", price: "12元" },
          { name: "赤豆酒酿", price: "5元" },
          { name: "赤豆糊小圆子", price: "6元" },
          { name: "红豆小圆子", price: "6元" }
        ]
      },
      {
        windowName: "UDIAN轻食",
        windowId: "2306",
        image: "Window2306",
        foodList: [
          { name: "鸡胸肉三明治", price: "8元" },
          { name: "牛排凤梨三明治", price: "9元" },
          { name: "谷物饭", price: "10元" },
          { name: "咖喱饭", price: "12元" },
          { name: "泡菜鸡胸肉拌饭", price: "12元" },
          { name: "黑椒意面", price: "8元" },
          { name: "番茄肉酱意面", price: "11元" },
          { name: "墨西哥鸡肉卷", price: "11元" },
          { name: "泡菜鸡肉卷", price: "11元" },
          { name: "UDIAN轻食照烧鸡丁拌饭", price: "10.5元" },
          { name: "时蔬鸡胸肉", price: "8.5元" },
          { name: "螺旋肉酱意面", price: "9.5元" },
          { name: "低卡荞麦面", price: "7.5元" },
          { name: "糙米饭团", price: "8元" },
          { name: "煎蛋", price: "1元" },
          { name: "贝贝南瓜", price: "1.5元" },
          { name: "牛排", price: "6元" },
          { name: "鸡胸肉", price: "3元" }
        ]
      }
    ]
  }
];

// 梧桐园食堂数据（待补充）
export const WUTONGYUAN_DATA: FloorItem[] = [
  // 待补充
];

// 蕙园食堂数据（待补充）
export const HUIYUAN_DATA: FloorItem[] = [
  // 待补充
];

// 榴园食堂数据（三层楼框架）
export const LIUYUAN_DATA: FloorItem[] = [
  // 榴园一楼
  {
    floorName: "一楼",
    windowList: [
      {
        windowName: "哎呦喂浓骨捞汤麻辣烫麻辣香锅",
        windowId: "3101",
        image: "Window3101",
        foodList: [
          { name: "麻辣烫/麻辣香锅（荤素同价，口味：原味/番茄）", price: "1.78元/50克" }
        ]
      },
      {
        windowName: "营养粥",
        windowId: "3102",
        image: "Window3102",
        foodList: [
          { name: "白米粥", price: "0.5元" },
          { name: "酒酿小圆子", price: "2.5元" },
          { name: "紫菜蛋花汤", price: "1元" },
          { name: "桂花糊+椰奶", price: "2.5元" },
          { name: "绿豆粥", price: "2元" },
          { name: "椰奶", price: "2.5元" },
          { name: "小米南瓜粥", price: "2.5元" },
          { name: "椰奶西米露", price: "3元" },
          { name: "红枣黑米粥", price: "2.5元" },
          { name: "红枣银耳粥", price: "3元" },
          { name: "皮蛋瘦肉粥", price: "2.5元" },
          { name: "原味豆浆", price: "2.5元" },
          { name: "椰奶燕麦粥", price: "2.5元" },
          { name: "红枣豆浆", price: "2.5元" },
          { name: "红枣山药粥", price: "2.5元" },
          { name: "黑芝麻糊", price: "2.5元" }
        ]
      },
      {
        windowName: "口水鸡",
        windowId: "3103",
        image: "Window3103",
        foodList: [
          { name: "招牌口水鸡(酸甜麻)", price: "11元" },
          { name: "百媚口水鸡(酸甜辣)", price: "11元" },
          { name: "红油口水鸡(香辣)", price: "11元" },
          { name: "口味: 原味微辣", price: "11元" },
          { name: "鱼香口水鸡", price: "11元" },
          { name: "黄焖鸡", price: "12元" },
          { name: "黄焖排骨", price: "12元" },
          { name: "黄焖酥肉", price: "11元" },
          { name: "重辣", price: "11元" },
          { name: "葱油口水鸡", price: "11元" }
        ]
      },
      {
        windowName: "小锅菜",
        windowId: "3104",
        image: "Window3104",
        foodList: [
          { name: "特色豆腐", price: "1.0元" },
          { name: "鱼豆腐肉片", price: "4.5元" },
          { name: "泡菜炒肉", price: "5.0元" },
          { name: "香辣鸡杂", price: "5.0元" },
          { name: "西红柿炒鸡蛋", price: "3.0元" },
          { name: "土豆肉丝", price: "3.5元" },
          { name: "牛心菜", price: "2.5元" },
          { name: "西兰花炒木耳", price: "4.0元" },
          { name: "香焖啤酒鸭", price: "5.0元" },
          { name: "山药肉片", price: "5.0元" },
          { name: "花菜回锅肉", price: "4.5元" },
          { name: "小青菜", price: "2.0元" },
          { name: "杭椒炒肉", price: "5.0元" },
          { name: "韭菜豆芽菜", price: "1.0元" }
        ]
      },
      {
        windowName: "重庆川味面",
        windowId: "3105",
        image: "Window3105",
        foodList: [
          { name: "糖醋排骨面", price: "12元" },
          { name: "红烧牛肉面", price: "11元" },
          { name: "土豆牛肉面", price: "11元" },
          { name: "鸡丝面", price: "11元" },
          { name: "川味辣子鸡面", price: "11元" },
          { name: "香菇鸡块面", price: "11元" },
          { name: "香辣鸡杂面", price: "10元" },
          { name: "香脆鸡腿面", price: "10元" },
          { name: "脆香鸡排面", price: "10元" },
          { name: "青椒肉丝面", price: "9元" },
          { name: "青鱼肉丝面", price: "9元" },
          { name: "金针肉丝面", price: "9元" },
          { name: "酸菜肉丝面", price: "8元" },
          { name: "酸辣笋尖面", price: "9元" },
          { name: "鲜笋面", price: "9元" },
          { name: "番茄鸡蛋面", price: "8元" },
          { name: "土豆炸酱面", price: "8元" },
          { name: "豆干面", price: "7元" },
          { name: "鸡蛋面", price: "7元" },
          { name: "青菜面", price: "5.5元" },
          { name: "招牌炸酱面", price: "8元" },
          { name: "糖醋排骨拌面", price: "12元" },
          { name: "红烧牛肉拌面", price: "11元" },
          { name: "土豆牛肉拌面", price: "11元" },
          { name: "鸡丝拌面", price: "11元" },
          { name: "川味辣子鸡拌面", price: "11元" },
          { name: "香菇鸡块拌面", price: "11元" },
          { name: "香辣鸡杂拌面", price: "10元" },
          { name: "三鲜拌面", price: "9元" },
          { name: "青椒肉丝拌面", price: "9元" },
          { name: "青鱼肉丝拌面", price: "9元" },
          { name: "金针肉丝拌面", price: "8元" },
          { name: "酸菜肉丝拌面", price: "8元" },
          { name: "酸辣笋尖拌面", price: "9元" },
          { name: "番茄鸡蛋拌面", price: "8元" },
          { name: "土豆杂酱拌面", price: "8元" },
          { name: "花生酱拌面", price: "7元" },
          { name: "葱油拌面", price: "7元" },
          { name: "糖醋排骨米线/粉丝", price: "12元" },
          { name: "红烧牛肉米线/粉丝", price: "11元" },
          { name: "土豆牛肉米线/粉丝", price: "11元" },
          { name: "鸡丝米线/粉丝", price: "12元" },
          { name: "川味辣子鸡米线/粉丝", price: "12元" },
          { name: "香菇鸡块米线/粉丝", price: "12元" },
          { name: "香辣鸡杂米线/粉丝", price: "11元" },
          { name: "香菇鸡腿米线/粉丝", price: "11元" },
          { name: "脆香鸡排米线/粉丝", price: "11元" },
          { name: "三鲜米线/粉丝", price: "10元" },
          { name: "青椒肉丝米线/粉丝", price: "10元" },
          { name: "鱼香肉丝米线/粉丝", price: "10元" },
          { name: "金针肉丝米线/粉丝", price: "9元" },
          { name: "酸菜肉丝米线/粉丝", price: "9元" },
          { name: "酸辣笋尖米线/粉丝", price: "10元" },
          { name: "番茄鸡蛋米线/粉丝", price: "9元" },
          { name: "土豆炸酱米线/粉丝", price: "9元" },
          { name: "方便面加鸡蛋", price: "6.5元" },
          { name: "方便面加火腿", price: "6元" },
          { name: "方便面加锅巴", price: "6.5元" },
          { name: "卤豆干", price: "1.5元/2片" },
          { name: "卤蛋", price: "1.5元/1个" },
          { name: "煎蛋", price: "1.5元/1个" },
          { name: "鸡排", price: "5元" },
          { name: "卤鸡腿", price: "5元" }
        ]
      },
      {
        windowName: "鲜煎猪扒饭",
        windowId: "3106",
        image: "Window3106",
        foodList: [
          { name: "鲜煎猪扒饭", price: "12元" },
          { name: "特色鸡扒饭", price: "12元" },
          { name: "双椒猪扒饭", price: "12元" },
          { name: "黑椒肉肠意大利面", price: "12元" },
          { name: "特色猪扒饭", price: "12元" },
          { name: "照烧猪扒饭", price: "12元" },
          { name: "深海鳕鱼意大利面", price: "12元" },
          { name: "双椒鸡扒饭", price: "12元" },
          { name: "番茄鸡扒饭", price: "12元" },
          { name: "双椒鸡扒意大利面", price: "12元" },
          { name: "照烧鸡扒饭", price: "12元" },
          { name: "芝士猪扒饭", price: "12元" },
          { name: "黑椒鸡扒意大利面", price: "12元" },
          { name: "番茄猪扒饭", price: "12元" },
          { name: "黑椒猪扒意大利面", price: "12元" },
          { name: "芝士鸡扒意大利面", price: "12元" },
          { name: "芝士鸡扒饭", price: "12元" },
          { name: "黑椒肉肠饭", price: "12元" },
          { name: "照烧鸡扒意大利面", price: "12元" },
          { name: "照烧肉肠意大利面", price: "12元" },
          { name: "芝士猪扒意大利面", price: "12元" },
          { name: "照烧猪扒意大利面", price: "12元" },
          { name: "深海鳕鱼饭", price: "12元" },
          { name: "脆皮鸡扒饭", price: "12元" },
          { name: "双椒猪扒意大利面", price: "12元" },
          { name: "肉肠", price: "3.5元/个" },
          { name: "鸡扒", price: "6元/份" }
        ]
      },
      {
        windowName: "轻食简餐",
        windowId: "3107",
        image: "Window3107",
        foodList: [
          { name: "鸡肉条谷物饭", price: "11元" },
          { name: "鸡肉条意面", price: "12元/份" },
          { name: "紫米芋泥芝士火烧", price: "8元/个" },
          { name: "麦香谷物饭", price: "9.9元/份" },
          { name: "麦香意面", price: "9.9元/份" },
          { name: "紫米芋泥肉松", price: "8元/个" },
          { name: "日式烧肉谷物饭", price: "12元/份" },
          { name: "鸡腿肉意面", price: "12元/份" },
          { name: "鸡腿肉谷物饭", price: "12元/份" },
          { name: "牛肉意面", price: "12元/份" },
          { name: "牛肉谷物饭", price: "12元/份" },
          { name: "鱼丸意面", price: "12元/份" }
        ]
      },
      {
        windowName: "健康营养",
        windowId: "3108",
        image: "Window3108",
        foodList: [
          { name: "干锅平包菜", price: "1元" },
          { name: "水晶冬瓜", price: "1元" },
          { name: "雪菜烧豆腐", price: "1元" },
          { name: "韭菜绿豆芽", price: "1元" },
          { name: "青椒萝卜丝", price: "1元" },
          { name: "肉末蒸鸡蛋", price: "1.5元" },
          { name: "鱼香土豆丝", price: "1.5元" },
          { name: "卤花干", price: "1.5元" },
          { name: "虎皮鸡蛋", price: "1.5元" },
          { name: "青椒茄子", price: "2元" },
          { name: "白菜豆腐", price: "1.5元" },
          { name: "洋葱干丝", price: "2.5元" },
          { name: "豆芽粉丝", price: "2.5元" },
          { name: "青椒炒干菜", price: "2.5元" },
          { name: "青椒酱汁", price: "2.5元" },
          { name: "萝卜炒干菜", price: "3元" },
          { name: "红烧圆子", price: "3元" },
          { name: "青椒海带丝", price: "3元" },
          { name: "西红柿炒鸡蛋", price: "3元" },
          { name: "生瓜炒肉片", price: "3.5元" },
          { name: "川香回锅肉", price: "4.5元" },
          { name: "豆角肉丝", price: "4.5元" },
          { name: "干锅花菜肉片", price: "4.5元" },
          { name: "干锅千页豆腐", price: "4.5元" },
          { name: "家常豆腐", price: "4.5元" },
          { name: "爆炒猪肝", price: "4.5元" },
          { name: "笋瓜肉片", price: "4.5元" },
          { name: "木耳肉片", price: "4.5元" },
          { name: "冬瓜炖排骨", price: "5元" },
          { name: "红烧大排", price: "5元" },
          { name: "雪菜烧肉", price: "5元" },
          { name: "海带炖肉", price: "5元" },
          { name: "毛豆烧铁板烧", price: "5元" },
          { name: "卤香酱鸭", price: "5元" },
          { name: "土豆鸡丁", price: "5元" },
          { name: "蒜苗炒心肉", price: "5元" },
          { name: "红烧琵琶腿", price: "5元" },
          { name: "杭椒鸡心", price: "5元" },
          { name: "蒜香米粉肉", price: "5元" },
          { name: "沙拉雪花鸡条", price: "5元" },
          { name: "麻辣鱼块", price: "5元" },
          { name: "黄豆烧猪手", price: "5元" },
          { name: "土豆烧鸡仔", price: "5元" }
        ]
      },
      {
        windowName: "精美点心",
        windowId: "3109",
        image: "Window3109",
        foodList: [
          { name: "鱼香肉丝包", price: "1元" },
          { name: "梅干菜包", price: "1元" },
          { name: "豆沙包", price: "1元" },
          { name: "香菇青菜包", price: "1元" },
          { name: "鲜肉包", price: "1元" },
          { name: "豆腐包", price: "1元" },
          { name: "蒸饺", price: "1元/2个" },
          { name: "白馒头", price: "0.5元" },
          { name: "葱油花卷", price: "1元" },
          { name: "鸡蛋", price: "1元" },
          { name: "脆骨肠", price: "2.5元" },
          { name: "火腿肠", price: "1.5元" },
          { name: "肉饼", price: "3元" },
          { name: "香菇青菜饼", price: "3元" },
          { name: "梅干菜饼", price: "3元" },
          { name: "杂粮土豆丝饼", price: "5元" },
          { name: "鸡蛋香肠饼", price: "2.5元" },
          { name: "手抓饼卷土豆丝", price: "4.5元" },
          { name: "芙蓉鸡蛋饼", price: "3元" },
          { name: "青椒鸡蛋饼", price: "3.5元" },
          { name: "肉夹馍", price: "3.5元" },
          { name: "牛肉饼", price: "4元" },
          { name: "芹菜饼", price: "3元" },
          { name: "鸡蛋饼", price: "1元" },
          { name: "糖糕", price: "1.5元" },
          { name: "麻球糕", price: "1.5元" },
          { name: "糕糕", price: "1.5元" },
          { name: "地瓜丸", price: "2元/3个" },
          { name: "烧饼", price: "1.5元" },
          { name: "蛋挞", price: "2.5元" },
          { name: "桂花米糕", price: "2元" },
          { name: "黑米糕", price: "2.5元" },
          { name: "红糖枣糕", price: "2元" },
          { name: "红糖馒头", price: "1元" },
          { name: "小米发糕", price: "3元" },
          { name: "肉松花卷", price: "1.5元" },
          { name: "大馍", price: "0.5元" },
          { name: "春卷", price: "1.5元" },
          { name: "肉松烤馍", price: "2元" },
          { name: "鸡蛋饼卷火腿", price: "2.5元" },
          { name: "火腿煎蛋", price: "3元" },
          { name: "肉松饭团", price: "3元" },
          { name: "杂粮馒头", price: "1元" }
        ]
      },
      {
        windowName: "鸡汤面",
        windowId: "3110",
        image: "Window3110",
        foodList: [
          { name: "鸡汤面", price: "7元" },
          { name: "土豆肉丝汤面", price: "8元" },
          { name: "西红柿鸡蛋汤面", price: "9元" },
          { name: "香辣鸭血汤面", price: "9元" },
          { name: "酸菜肉丝汤面", price: "9元" },
          { name: "毛豆鸡汤面", price: "10元" },
          { name: "鸡丝汤面", price: "10元" },
          { name: "香辣鸡杂汤面", price: "11元" },
          { name: "豆角肉丝汤面", price: "11元" },
          { name: "肉沫茄子汤面", price: "11元" },
          { name: "红烧牛肉汤面", price: "12元" },
          { name: "大盘鸡汤面", price: "12元" },
          { name: "红烧肉汤面", price: "12元" },
          { name: "孜然肉汤面", price: "12元" },
          { name: "小炒肉汤面", price: "11元" },
          { name: "大排汤面", price: "11元" },
          { name: "葱油拌面", price: "7元" },
          { name: "炸酱面", price: "10元" },
          { name: "土豆肉丝拌面", price: "8元" },
          { name: "西红柿鸡蛋拌面", price: "9元" },
          { name: "香辣鸭血拌面", price: "9元" },
          { name: "酸菜肉丝拌面", price: "9元" },
          { name: "三鲜菌菇汤面", price: "10元" },
          { name: "鸡汤刀削面", price: "7元" },
          { name: "土豆肉丝刀削面", price: "8元" },
          { name: "西红柿鸡蛋刀削面", price: "9元" },
          { name: "香辣鸭血刀削面", price: "9元" },
          { name: "酸菜肉丝刀削面", price: "9元" },
          { name: "毛豆刀削面", price: "10元" },
          { name: "炸酱米线", price: "10元" },
          { name: "土豆肉丝米线", price: "8元" },
          { name: "香辣鸭血米线", price: "9元" },
          { name: "温州瘦肉丸", price: "11元" },
          { name: "孜然肉丝刀削面", price: "10元" },
          { name: "爆螺蛳", price: "11元" },
          { name: "煎蛋", price: "1.5元/个" }
        ]
      },
      {
        windowName: "滋土客",
        windowId: "3111",
        image: "Window3111",
        foodList: [
          { name: "香辣鸡腿堡", price: "7元" },
          { name: "新奥尔良烤鱼堡", price: "8元" },
          { name: "墨西哥鸡肉卷", price: "7元" },
          { name: "劲爆鸡米花", price: "6元" },
          { name: "泰式鸡肉卷", price: "8元" },
          { name: "上校鸡块", price: "5元" },
          { name: "牛肉堡", price: "6元" },
          { name: "薯条+鸡肉卷+中可", price: "14元" },
          { name: "双层牛肉堡", price: "8元" },
          { name: "无骨鸡柳", price: "6元" },
          { name: "田园蔬菜堡", price: "6元" },
          { name: "骨肉相连", price: "4元" },
          { name: "深海鳕鱼堡", price: "8元" },
          { name: "炸鸡腿", price: "6元" },
          { name: "蟹黄堡", price: "9元" },
          { name: "蛋挞", price: "6元" },
          { name: "藤椒鸡腿堡", price: "7元" },
          { name: "拉丝芝士棒", price: "7元" },
          { name: "蜜汁手扒鸡", price: "9.9元" },
          { name: "黄金蝴蝶虾", price: "6元" },
          { name: "脆皮金鸡", price: "9.9元" },
          { name: "洋葱卷", price: "5元" },
          { name: "台湾鸡排", price: "10元" },
          { name: "整只堡", price: "5元" },
          { name: "烤全腿", price: "9元" },
          { name: "鸡肉卷套餐 (汉堡+鸡肉卷+中可)", price: "14元" },
          { name: "鸡排套餐 (鸡排+大可)", price: "13元" },
          { name: "辣翅套餐 (汉堡+辣翅+中可)", price: "14元" },
          { name: "休闲小吃套餐 (鸡米花+鸡块+小薯+中可)", price: "16元" },
          { name: "烤翅套餐 (鸡肉卷+烤翅+中可)", price: "15元" },
          { name: "吉祥三宝 (汉堡+烤堡+牛堡)", price: "16元" },
          { name: "牛堡套餐 (牛堡+小薯+鸡块+中可)", price: "15元" },
          { name: "A套餐 (汉堡+鸡块+中可)", price: "13元" },
          { name: "薯条套餐 (7堡+大薯+中可)", price: "14元" },
          { name: "虾堡套餐 (虾堡+大薯+中可)", price: "15元" },
          { name: "手扒鸡套餐 (手扒鸡+中可)", price: "18元" },
          { name: "B套餐 (汉堡+鸡柳+小薯+中可)", price: "17元" },
          { name: "超值套餐 (汉堡+汉堡)", price: "11元" },
          { name: "特惠套餐 (汉堡+小可)", price: "8元" },
          { name: "烤堡套餐 (烤堡+鸡块+烤翅+中可)", price: "19元" },
          { name: "全家福套餐 (3个汉堡+手扒鸡+鸡柳+鸡块+鸡米花+大薯+3杯中可)", price: "58元" }
        ]
      },
      {
        windowName: "益禾堂",
        windowId: "3112",
        //image: "Window3112",
        foodList: [
          { name: "薄荷巧乐冰", price: "中杯15元 大杯13.9元" },
          { name: "薄荷奶芙", price: "中杯15元 大杯13.9元" },
          { name: "芝士奶芙", price: "中杯12元 大杯15元" },
          { name: "桃桃奶芙", price: "中杯12元 大杯15元" },
          { name: "益禾堂奶茶", price: "中杯7元 大杯10元" },
          { name: "益禾烤奶", price: "中杯7元 大杯10元" },
          { name: "益杯百香果", price: "中杯10元 大杯13元" },
          { name: "冰淇淋红茶", price: "中杯7元 大杯10元" },
          { name: "禾风奶绿", price: "中杯7元 大杯10元" },
          { name: "四季奶青", price: "中杯9元 大杯12元" },
          { name: "泞泞耶耶", price: "中杯9元 大杯12元" },
          { name: "泞泞四季春", price: "中杯9元 大杯12元" },
          { name: "芝士奶盖绿茶", price: "中杯9元 大杯12元" },
          { name: "芝士奶盖红茶", price: "中杯9元 大杯12元" },
          { name: "芝士奶盖四季春", price: "中杯9元 大杯12元" },
          { name: "蜜桃四季春", price: "中杯10元 大杯13元" },
          { name: "葡萄四季春", price: "中杯10元 大杯13元" },
          { name: "草莓四季春", price: "中杯10元 大杯13元" },
          { name: "杨梅四季春", price: "中杯10元 大杯13元" },
          { name: "满杯水果茶", price: "中杯12元 大杯15元" },
          { name: "满杯百香果", price: "中杯12元 大杯15元" },
          { name: "超级水果茶", price: "中杯13元 大杯16元" },
          { name: "超级百香果", price: "中杯13元 大杯16元" },
          { name: "一颗大柠檬", price: "中杯8元 大杯11元" },
          { name: "一颗大柠檬红茶", price: "中杯8元 大杯11元" },
          { name: "一颗大柠檬绿茶", price: "中杯8元 大杯11元" },
          { name: "一颗大柠檬四季春", price: "中杯8元 大杯11元" },
          { name: "一颗大柠檬蜜桃", price: "中杯10元 大杯13元" },
          { name: "一颗大柠檬葡萄", price: "中杯10元 大杯13元" },
          { name: "一颗大柠檬草莓", price: "中杯10元 大杯13元" },
          { name: "一颗大柠檬杨梅", price: "中杯10元 大杯13元" },
          { name: "一颗大柠檬百香果", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬芒果", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬西瓜", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬菠萝", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬椰子", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬哈密瓜", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬蓝莓", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬奇异果", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬橙子", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬柚子", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬青柠", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬金桔", price: "中杯12元 大杯15元" },
          { name: "一颗大柠檬柠檬", price: "中杯12元 大杯15元" }
        ]
      },
      {
        windowName: "古法炸鸡腿",
        windowId: "3113",
        //image: "Window3113",
        foodList: [
          { name: "古法炸鸡腿", price: "6元/个" },
          { name: "古法炸鸡翅", price: "3元/个" },
          { name: "古法炸鸡块", price: "8元/份" },
          { name: "古法炸鸡排", price: "10元/份" },
          { name: "古法炸鸡柳", price: "8元/份" },
          { name: "古法炸鸡米花", price: "6元/份" },
          { name: "黄金鸡腿肉", price: "12元/250g" },
          { name: "黄金鸡腿肉", price: "4元/个, 10元/3个" },
          { name: "黄金带骨鸡", price: "10元/250g" },
          { name: "甘梅地瓜条", price: "7元/5条" }
        ]
      }
    ]
  },
  // 榴园二楼
  {
    floorName: "二楼",
    windowList: [
      {
        windowName: "瓦香鸡米饭",
        windowId: "3201",
        //image: "Window3201",
        foodList: [
          { name: "瓦香鸡米饭", price: "12元" },
          { name: "瓦香年糕鸡", price: "11元" },
          { name: "瓦香手撕面筋", price: "11元" },
          { name: "瓦香脆皮豆腐", price: "11元" },
          { name: "瓦香小酥肉", price: "12元" },
          { name: "瓦香包菜", price: "8元" }
        ]
      },
      {
        windowName: "瓦罐焖面",
        windowId: "3202",
        image: "Window3202",
        foodList: [
          { name: "排骨焖面", price: "12元" },
          { name: "红烧肉焖面", price: "12元" },
          { name: "鸡块焖面", price: "11元" },
          { name: "酥肉焖面", price: "11元" },
          { name: "豆角焖面", price: "10元" },
          { name: "土豆焖面", price: "10元" }
        ]
      },
      {
        windowName: "朱家小馆",
        windowId: "3203",
        image: "Window3203",
        foodList: [
          { name: "招牌卤肉饭", price: "12元" },
          { name: "香辣鸡块饭", price: "12元" },
          { name: "红烧肉饭", price: "12元" },
          { name: "糖醋里脊饭", price: "12元" },
          { name: "宫保鸡丁饭", price: "11元" },
          { name: "鱼香肉丝饭", price: "11元" }
        ]
      },
      {
        windowName: "湖南渔粉",
        windowId: "3204",
        image: "Window3204",
        foodList: [
          { name: "招牌渔粉", price: "12元" },
          { name: "酸菜渔粉", price: "12元" },
          { name: "番茄渔粉", price: "11元" },
          { name: "三鲜渔粉", price: "11元" },
          { name: "麻辣渔粉", price: "12元" },
          { name: "原味渔粉", price: "10元" }
        ]
      },
      {
        windowName: "前浪猛火炒饭",
        windowId: "3205",
        image: "Window3205",
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
          { name: "剁椒肉丝蛋炒饭", price: "12元" },
          { name: "奥尔良鸡腿排炒饭", price: "12元" },
          { name: "小香葱蛋炒饭", price: "12元" }
        ]
      },
      {
        windowName: "江南小灶",
        windowId: "3206",
        //image: "liuyuan_jiangnanxiaozao",
        foodList: [
          { name: "小炒肉", price: "12元" },
          { name: "农家小炒鸡", price: "12元" },
          { name: "香干炒肉", price: "11元" },
          { name: "芹菜炒肉", price: "11元" },
          { name: "蒜苔炒肉", price: "11元" },
          { name: "豆角炒肉", price: "11元" }
        ]
      },
      {
        windowName: "精品快餐",
        windowId: "3207",
        image: "Window3207",
        foodList: [
          { name: "红烧肉", price: "5元" },
          { name: "糖醋里脊", price: "5元" },
          { name: "宫保鸡丁", price: "5元" },
          { name: "鱼香肉丝", price: "5元" },
          { name: "辣子鸡丁", price: "5元" },
          { name: "红烧鸡腿", price: "5元" },
          { name: "土豆烧鸡", price: "4元" },
          { name: "西红柿炒蛋", price: "3元" },
          { name: "青椒土豆丝", price: "3元" },
          { name: "麻婆豆腐", price: "3元" }
        ]
      },
      {
        windowName: "李府甲味轩",
        windowId: "3208",
        //image: "liuyuan_lifujianweixuan",
        foodList: [
          { name: "甲鱼炖鸡", price: "15元" },
          { name: "红烧甲鱼", price: "14元" },
          { name: "清蒸甲鱼", price: "14元" },
          { name: "甲鱼汤", price: "12元" },
          { name: "黄焖鸡", price: "12元" },
          { name: "红烧鸡块", price: "11元" }
        ]
      },
      {
        windowName: "麻辣香锅",
        windowId: "3209",
        //image: "liuyuan_malaxiangguo",
        foodList: [
          { name: "麻辣香锅（素）", price: "10元" },
          { name: "麻辣香锅（荤素搭配）", price: "12元" },
          { name: "麻辣香锅（全荤）", price: "15元" },
          { name: "加米饭", price: "1元" }
        ]
      },
      {
        windowName: "酸菜肉煲",
        windowId: "3210",
        image: "Window3210",
        foodList: [
          { name: "酸菜肉煲", price: "12元" },
          { name: "酸菜鱼煲", price: "12元" },
          { name: "酸菜鸡煲", price: "11元" },
          { name: "酸菜排骨煲", price: "12元" },
          { name: "加米饭", price: "1元" }
        ]
      },
      {
        windowName: "淮南牛肉汤",
        windowId: "3211",
        image: "Window3211",
        foodList: [
          { name: "牛肉粉丝", price: "11元" },
          { name: "牛肉米线", price: "11元" },
          { name: "牛肉土豆粉", price: "11元" },
          { name: "鸡肉粉丝", price: "11元" },
          { name: "鸭血米线", price: "11元" },
          { name: "鸭血土豆粉", price: "11元" },
          { name: "素粉丝", price: "8元" },
          { name: "素米线", price: "9元" },
          { name: "素土豆粉", price: "10元" },
          { name: "展沟烧饼", price: "4元" },
          { name: "鸡丝米线", price: "11元" },
          { name: "牛肉泡锅巴", price: "10元" },
          { name: "杂酱刀削面", price: "11元" }
        ]
      }
    ]
  },
  // 榴园三楼
  {
    floorName: "三楼",
    windowList: [
      {
        windowName: "鲜烫牛肉米线",
        windowId: "3301",
        image: "Window3301",
        foodList: [
          { name: "鲜烫牛肉米线", price: "9.9元" },
          { name: "老坛酸菜米线", price: "9.9元" },
          { name: "云南傣味米线", price: "9.9元" },
          { name: "日光番茄米线", price: "9.9元" },
          { name: "经典火锅米线", price: "9.9元" },
          { name: "加牛肉", price: "6元" },
          { name: "加鸡肉片", price: "4元" },
          { name: "加香肠", price: "3元" },
          { name: "加鱼豆腐", price: "2元" },
          { name: "加肉片", price: "2元" }
        ]
      },

      {
        windowName: "麻辣烫/麻辣拌/麻辣香锅",
        windowId: "3302",
        //image: "Window3211",
        foodList: [
          { name: "荤素统一价", price: "17.8元/500克" },
          { name: "娃娃菜", price: "1元" },
          { name: "紫菜", price: "1元" },
          { name: "金针菇", price: "1元" },
          { name: "香菇", price: "1元" },
          { name: "平菇", price: "1元" },
          { name: "上海青", price: "1元" },
          { name: "韭菜", price: "1元" },
          { name: "年糕片", price: "1元" },
          { name: "素鸡", price: "1元" },
          { name: "冻豆腐", price: "1元" },
          { name: "油面筋", price: "1元" },
          { name: "鸡胗", price: "2元" },
          { name: "里脊肉(肉串)", price: "3.5元" },
          { name: "小把肉(肉串)", price: "3元" },
          { name: "蟹棒", price: "2元" },
          { name: "鸡排", price: "4.5元" },
          { name: "肉排(肉串)", price: "5元" }
        ]
      },
      {
        windowName: "锡纸烧米饭",
        windowId: "3303",
        image: "Window3303",
        foodList: [
          { name: "锡纸鸡烧米饭（微辣/正常）", price: "11元" },
          { name: "锡纸牛肉烧米饭（中辣/小辣椒酸菜/日食香菇/番茄）", price: "12元" },
          { name: "锡纸肉片烧米饭（微辣/中辣/日食香菇/番茄）", price: "12元" },
          { name: "锡纸无骨鱼片烧米饭（微辣/中辣/日食香菇/番茄/茴香）", price: "12元" },
          { name: "锡纸三文鱼烧米饭（微辣/中辣/日食香菇/番茄/茴香）", price: "10元" },
          { name: "锡纸香豆腐烧米饭（微辣/中辣/小辣椒酸菜/日食香菇/番茄）", price: "8元" },
          { name: "锡纸小酥肉烧米饭（微辣/中辣/日食香菇/番茄/茴香）", price: "11元" }
        ]
      },
      {
        windowName: "武汉黑鸭煲",
        windowId: "3304",
        image: "Window3304",
        foodList: [
          { name: "回味黑鸭煲", price: "12元" },
          { name: "麻香鸭", price: "12元" },
          { name: "招牌武汉黑鸭煲", price: "12元" },
          { name: "黑鸭牛丸煲", price: "12元" },
          { name: "黑鸭红烧肉煲", price: "12元" },
          { name: "黑鸭腐竹煲", price: "12元" },
          { name: "黑鸭土豆粉煲", price: "12元" },
          { name: "黑鸭小酥肉煲", price: "12元" },
          { name: "黑鸭木耳煲", price: "11元" },
          { name: "黑鸭海带煲", price: "10元" }
        ]
      },
      {
        windowName: "湘西小炒盖码饭",
        windowId: "3305",
        image: "Window3305",
        foodList: [
          { name: "干香回锅肉", price: "12元" },
          { name: "湘西辣子鸡", price: "12元" },
          { name: "余干椒炒肉", price: "12元" },
          { name: "腊肉炒香干", price: "12元" },
          { name: "农家一碗香", price: "12元" },
          { name: "萍乡小炒鸡", price: "12元" },
          { name: "农家井冈山豆腐皮", price: "12元" },
          { name: "豉香皮蛋茄子", price: "12元" },
          { name: "湘西金钱蛋", price: "10元" },
          { name: "家味土豆丝", price: "10元" }
        ]
      },
      {
        windowName: "韩式拌饭",
        windowId: "3306",
        image: "Window3306",
        foodList: [
          { name: "烤肉", price: "5元" },
          { name: "鱿鱼卷", price: "4元" },
          { name: "五花肉", price: "4元" },
          { name: "里脊肉", price: "3元" },
          { name: "小酥肉", price: "3元" },
          { name: "韩式拌饭", price: "11元" },
          { name: "什锦海苔拌饭", price: "10元" },
          { name: "鱼豆腐", price: "5元" },
          { name: "青椒肉", price: "4元" },
          { name: "黑椒肉柳", price: "4元" },
          { name: "腊肠", price: "3元" },
          { name: "培根", price: "3元" },
          { name: "鸡柳", price: "3元" }
        ]
      },
      {
        windowName: "招牌黄焖鸡/南昌拌粉",
        windowId: "3307",
        image: "Window3307",
        foodList: [
          { name: "南昌拌粉（酱香/香辣/麻辣）", price: "9元" },
          { name: "黄焖小酥肉（原味/微辣/中辣/特辣）", price: "11元" },
          { name: "黄焖鸡（原味/微辣/中辣/特辣）", price: "12元" },
          { name: "黄焖排骨（原味/微辣/中辣/特辣）", price: "12元" },
          { name: "黄焖去骨蹄膀（原味/微辣/中辣/特辣）", price: "12元" }
        ]
      },
      {
        windowName: "黑金热卤拌饭",
        windowId: "3308",
        image: "Window3308",
        foodList: [
          { name: "黑金猪肘饭", price: "12元" },
          { name: "手撕大排饭", price: "12元" },
          { name: "麻辣龙骨饭", price: "12元" },
          { name: "热卤大肉饭", price: "12元" },
          { name: "招牌口水鸡", price: "11元" },
          { name: "金牌鸭腿饭", price: "11元" },
          { name: "自然烤鸭饭", price: "11元" },
          { name: "焦糖可乐鸡翅根饭", price: "11元" },
          { name: "黄金鸡排饭", price: "11元" },
          { name: "港式小酥肉饭", price: "11元" }
        ]
      },
      {
        windowName: "螺狮粉",
        windowId: "3309",
        image: "Window3309",
        foodList: [
          { name: "南昌拌粉", price: "9元" },
          { name: "原味螺蛳粉", price: "10元" },
          { name: "烤肠螺蛳粉", price: "11元" },
          { name: "煎蛋螺蛳粉", price: "11.5元" },
          { name: "炸蛋螺蛳粉", price: "12元" },
          { name: "烤肠", price: "1元/根" },
          { name: "煎蛋", price: "1.5元/个" },
          { name: "炸蛋", price: "1.5元/2.5个" },
          { name: "免费加粉", price: "" }
        ]
      },
      {
        windowName: "状元鸡米饭",
        windowId: "3310",
        image: "Window3310",
        foodList: [
          { name: "果木香", price: "11元" },
          { name: "十三香", price: "11元" },
          { name: "台式三杯鸡", price: "11元" },
          { name: "瓦香风味鸡", price: "11元" },
          { name: "甜味五花肉", price: "12元" },
          { name: "红咖喱牛肉饭", price: "12元" }
        ]
      },
      {
        windowName: "新疆炒米粉",
        windowId: "3311",
        image: "Window3311",
        foodList: [
          { name: "新疆炒米粉", price: "10元" },
          { name: "火腿炒米粉", price: "11元" },
          { name: "年糕炒米粉", price: "11元" },
          { name: "鸡肉炒米粉", price: "12元" },
          { name: "小酥肉炒米粉", price: "12元" },
          { name: "里脊炒米粉", price: "12元" },
          { name: "爆炒米粉", price: "12元" }
        ]
      },
      {
        windowName: "咕咕鸡",
        windowId: "3312",
        image: "Window3312",
        foodList: [
          { name: "招牌咕咕鸡", price: "12元" },
          { name: "小酥肉", price: "12元" },
          { name: "涮肉卷", price: "12元" },
          { name: "咕咕火腿", price: "10元" }
        ]
      },
      {
        windowName: "油泼鸡",
        windowId: "3313",
        image: "Window3313",
        foodList: [
          { name: "招牌油泼鸡", price: "12元" },
          { name: "特色油泼小酥肉", price: "12元" },
          { name: "油泼鱼片", price: "12元" },
          { name: "油泼小酥肉", price: "11元" },
          { name: "油泼淮扬三鲜", price: "12元" },
          { name: "油泼肉卷", price: "11元" },
          { name: "油泼肉片", price: "12元" }
        ]
      },
      {
        windowName: "羊杂面",
        windowId: "3314",
        image: "Window3314",
        foodList: [
          { name: "羊杂面", price: "12元" },
          { name: "大肉面", price: "12元" },
          { name: "牛肉面", price: "12元" },
          { name: "辣肉面", price: "12元" },
          { name: "酸菜肉末面", price: "10元" },
          { name: "酸豆角肉末面", price: "10元" },
          { name: "炸酱面", price: "10元" },
          { name: "特色麻酱拌面", price: "8元" },
          { name: "麻酱鸡丝拌面", price: "11元" },
          { name: "麻酱酸豆角肉末拌面", price: "10元" },
          { name: "麻酱酸菜肉末拌面", price: "10元" },
          { name: "麻酱辣肉拌面", price: "12元" },
          { name: "麻酱牛肉拌面", price: "12元" },
          { name: "麻酱羊杂拌面", price: "12元" }
        ]
      },
      {
        windowName: "旋转小火锅",
        windowId: "3315",
        //image: "Window3211",
        foodList: [
          { name: "旋转小火锅", price: "按签定价" },
          ]
      },
    ]
  }
];

// 外招食堂数据（待补充）
export const WAIZHAO_DATA: FloorItem[] = [
  // 待补充
];

// 一食堂数据（待补充）
export const YISHITANG_DATA: FloorItem[] = [
  // 待补充
];

// 二食堂数据（待补充）
export const ERSHITANG_DATA: FloorItem[] = [
  // 待补充
];

// 三食堂数据（待补充）
export const SANSHITANG_DATA: FloorItem[] = [
  // 待补充
];
