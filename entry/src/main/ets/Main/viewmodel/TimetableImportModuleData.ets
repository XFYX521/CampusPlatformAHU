import LazyDataSource from '../util/LazyDataSource';

export class DataSource {
  id: string;
  name: string;
  completed: number;
  total: number;
  icon: Resource;

  constructor(id: string, name: string, completed: number, total: number, icon: Resource) {
    this.id = id;
    this.name = name;
    this.completed = completed;
    this.total = total;
    this.icon = icon;
  }

  getId(): string {
    return this.id;
  }

  getName(): string {
    return this.name;
  }

  getCompleted(): number {
    return this.completed;
  }

  getTotal(): number {
    return this.total;
  }

  getIcon(): Resource {
    return this.icon;
  }

  getCompletionPercentage(): number {
    if (this.total === 0) return 0;
    return (this.completed / this.total) * 100;
  }
}

export class Data {
  private static instance: Data;
  private lazyDataSource: LazyDataSource<DataSource> = new LazyDataSource<DataSource>();
  static readonly SUBJECT_IDS: string[] = ['CS101', 'MATH201', 'PHY301', 'ENG401'];
  static readonly SUBJECT_NAMES: string[] = ['计算机科学导论', '高等数学', '大学物理', '英语阅读与写作'];
  static readonly COMPLETED_COUNTS: number[] = [
    0,
    0,
    0,
    0,
    0,
    0
  ];
  static readonly TOTAL_COUNTS: number[] = [
    864,
    3247,
    6662,
    2769,
    8416,
    3809
  ];
  static readonly SUBJECT_ICONS: Resource[] = [
    $r('app.media.ca'),
    $r('app.media.ca'),
    $r('app.media.ca'),
    $r('app.media.ca')];

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
   * 获取学科进度数据
   */
  getResources(): Promise<void> {
    return new Promise((resolve: Function, reject: Function) => {
      try {
        const subjectList: Array<DataSource> = [];
        for (let i = 0; i < Data.SUBJECT_NAMES.length; i++) {
          subjectList.push(new DataSource(
            Data.SUBJECT_IDS[i],
            Data.SUBJECT_NAMES[i],
            Data.COMPLETED_COUNTS[i],
            Data.TOTAL_COUNTS[i],
            Data.SUBJECT_ICONS[i]
          ));
        }
        this.lazyDataSource.pushArrayData(subjectList);
        resolve();
      } catch (error) {
        reject(error);
      }
    });
  }
}