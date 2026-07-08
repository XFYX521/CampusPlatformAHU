export class Data {
  private static instance: Data;
  private headPhoneIcon: Resource = $r('app.media.ic_headphones_lined');
  private VerticalGraphicTextFunctionItemModel: DataSource[] = [];
  static readonly IMAGES: Resource[] =
    [$r('app.media.New1'), $r('app.media.New2'), $r('app.media.New3')];
  static readonly TITLES: string[] = ['教务通知', '新闻动态', '学术公告'];
  static readonly DESCRIPTIONS: string[] = ['', '', ''];

  private constructor() {
    for (let i = 0; i < Data.IMAGES.length; i++) {
      this.VerticalGraphicTextFunctionItemModel.push(new DataSource(
        Data.IMAGES,
        Data.TITLES,
        Data.DESCRIPTIONS,
      ));
    }
  }

  public static getInstance(): Data {
    if (!Data.instance) {
      Data.instance =
        new Data();
    }
    return Data.instance;
  }

  getItemModel(): DataSource[] {
    return this.VerticalGraphicTextFunctionItemModel;
  }

  getHeadPhoneIcon(): Resource {
    return this.headPhoneIcon;
  }
}

export class DataSource {
  private icon: Resource[];
  private title: string[];
  private description: string[];

  constructor(icon: Resource[], title: string[], description: string[]) {
    this.icon = icon;
    this.title = title;
    this.description = description;
  }

  getIcon(): Resource[] {
    return this.icon;
  }

  getTitle(): string[] {
    return this.title;
  }

  getDescription(): string[] {
    return this.description;
  }
}