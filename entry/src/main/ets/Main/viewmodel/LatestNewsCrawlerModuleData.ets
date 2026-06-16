import LazyDataSource from '../util/LazyDataSource';

export class Data {
  private static instance: Data;
  lazyDataSource: LazyDataSource<HorizontalTextButtonFunctionItemModel> = new LazyDataSource();
  static readonly TITLES: string[] =
    ['教务通知', '教务快讯', '教务快讯', '教务快讯', '教务快讯', '教务快讯', '教务快讯', '教务快讯', '教务快讯',
      '教务快讯'];
  static readonly SUB_TITLES: string[] =
    ['关于2024-2025学年第一学期选课安排的通知', '关于2024届毕业生学位授予工作的通知', '关于举办教学创新大赛的预通知',
      '关于期末考试考场安排的通知', '关于教材征订工作的补充说明', '我校教师在省级教学竞赛中获佳绩',
      '教务处召开新学期教学工作部署会', '智慧教学平台升级完成通知', '学生评教工作即将启动',
      '教学改革项目中期检查结果公布'];
  static readonly BUTTON_VALUES: string[] =
    ['查看详情', '更多通知', '更多资讯', '更多资讯', '更多资讯', '更多资讯', '更多资讯', '更多资讯', '更多资讯',
      '更多资讯'];

  constructor() {
  }

  public static getInstance(): Data {
    if (!Data.instance) {
      Data.instance =
        new Data();
    }
    return Data.instance;
  }

  /**
   * Data loaded on current view converts network data into rendering data
   */
  getResources(): Promise<void> {
    /**
     * use your web request here
     */
    return new Promise((resolve: Function) => {
      const modelList: Array<HorizontalTextButtonFunctionItemModel> = [];
      for (let index = 0; index < Data.TITLES.length;
        index++) {
        modelList.push(new HorizontalTextButtonFunctionItemModel(
          Data.TITLES[index],
          Data.SUB_TITLES[index],
          Data.BUTTON_VALUES[index]
        ))
      }
      this.lazyDataSource.pushArrayData(modelList);
      resolve();
    });
  }
}

export class HorizontalTextButtonFunctionItemModel {
  private title: string;
  private subTitle: string;
  private buttonValue: string;

  constructor(title: string, subTitle: string, buttonValue: string) {
    this.title = title;
    this.subTitle = subTitle;
    this.buttonValue = buttonValue;
  }

  getTitle(): string {
    return this.title;
  }

  getSubTitle(): string {
    return this.subTitle;
  }

  getButtonValue(): string {
    return this.buttonValue;
  }
}