import LazyDataSource from '../util/LazyDataSource';

export class DataSource {
  private title: string;
  private description: string;
  private tags: string[];
  private teacherAvatars: Resource[];
  private priceRange: string;
  private saleStatus: string;
  private purchaseCount: string;
  private timeRemaining: string;
  private onSale: boolean;

  constructor(
    title: string,
    description: string,
    tags: string[],
    teacherAvatars: Resource[],
    priceRange: string,
    saleStatus: string,
    purchaseCount: string,
    timeRemaining: string,
    onSale: boolean
  ) {
    this.title = title;
    this.description = description;
    this.tags = tags;
    this.teacherAvatars = teacherAvatars;
    this.priceRange = priceRange;
    this.saleStatus = saleStatus;
    this.purchaseCount = purchaseCount;
    this.timeRemaining = timeRemaining;
    this.onSale = onSale;
  }

  getTitle(): string {
    return this.title;
  }

  getDescription(): string {
    return this.description;
  }

  getTags(): string[] {
    return this.tags;
  }

  getTeacherAvatars(): Resource[] {
    return this.teacherAvatars;
  }

  getPriceRange(): string {
    return this.priceRange;
  }

  getSaleStatus(): string {
    return this.saleStatus;
  }

  getPurchaseCount(): string {
    return this.purchaseCount;
  }

  getTimeRemaining(): string {
    return this.timeRemaining;
  }

  isOnSale(): boolean {
    return this.onSale;
  }
}

export class Data {
  private static instance: Data;
  private lazyDataSource: LazyDataSource<DataSource> = new LazyDataSource<DataSource>();
  private static TITLES: string[] = ['导入课表', '更换课表'];
  private static DESCRIPTIONS: string[] = ['', ''];
  private static PRICES: string[] = ['免费', '免费'];

  private constructor() {
    this.lazyDataSource = new LazyDataSource<DataSource>();
  }

  public static getInstance(): Data {
    if (!Data.instance) {
      Data.instance = new Data();
    }
    return Data.instance;
  }

  getLazyDataSource(): LazyDataSource<DataSource> {
    return this.lazyDataSource;
  }

  /**
   * 获取课程卡片数据
   */
  getResources(): Promise<void> {
    /**
     * use your web request here
     */
    return new Promise((resolve: Function) => {
      const modelList: Array<DataSource> = [];
      for (let index = 0; index < Data.TITLES.length;
        index++) {
        modelList.push(new DataSource(
          Data.TITLES[index],
          Data.DESCRIPTIONS[index],
          ['引领智学时代', '效率能力双提升'],
          [
            $r('app.media.avatar'),
            $r('app.media.avatar'),
            $r('app.media.avatar')
          ],
          Data.PRICES[index],
          '',
          '219',
          '1小时',
          true
        ));
      }
      this.lazyDataSource.pushArrayData(modelList);
      resolve();
    });
  }
}