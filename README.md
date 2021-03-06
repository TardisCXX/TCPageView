# TCPageView

**TCPageView** 是一个不错的选项视图功能组件，它高度封装和集成简单。

## TCPageView的使用
在需要用到的地方 `import TCPageView`

当需要使用`控制器`push或者modal子控制器，就在`viewDidLoad`或者 `其他创建UI的函数` 中调用：

```Swift
    // 如果父控制器是UINavigationController，那么就需要下面一行代码
    automaticallyAdjustsScrollViewInsets = false

    let style = TCHeaderStyle()
    style.isScroll = true
    // style.isShowBottomLine = true
    // style.isScaleEnabel = true
    style.isShowCover = true

    // let titles = ["热门", "头条", "地理", "文学", "历史"]
    let titles = ["热门", "头条", "天文地理", "史前文明", "人类大科技", "暴雪游戏嘉年华", "漫威世界之平行宇宙", "美女日常"]


    var childControllers = [UIViewController]()

    for _ in 0..<titles.count {
        let vc = UIViewController()
        vc.view.backgroundColor = .randomColor
        childControllers.append(vc)
        self.addChildViewController(vc)
    }

    let pageRect = CGRect(x: 0, y: 64.0, width: view.bounds.width, height: view.bounds.height - 64.0)
    let pageView = TCPageView(frame: pageRect, style: style, titles: titles, childControllers: childControllers, rootController: self)
    pageView.backgroundColor = .randomColor
    view.addSubview(pageView)
```
---
当需要使用`collectionView`或者`单纯view`添加子视图时，就在`viewDidLoad`或者 `其他创建UI的函数` 中调用：
```Swift
let style = TCHeaderStyle()

let titles = ["热门", "头条", "地理", "文学"]

let layout = TCPageViewFlowLayout()
layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
layout.minimumLineSpacing = 10
layout.minimumInteritemSpacing = 10
layout.scrollDirection = .horizontal
layout.cols = 5
layout.rows = 3

let pageRect = CGRect(x: 0, y: 64.0, width: view.bounds.width, height: 300.0)
let pageView = TCPageView(frame: pageRect, style: style, titles: titles, layout:layout)
pageView.backgroundColor = .randomColor
view.addSubview(pageView)
// 设置数据源
pageView.dataSource = self
// 如有需要设置代理
pageView.delegate = self
// 注册cell
pageView.registerCell(UICollectionViewCell.self, identifier: kUICollectionViewCellIdentifier)

```
实现数据源方法：
```Swift
extension ViewController: TCPageViewDataSource {

    func numberOfSectionInPageView(_ pageView: TCPageView) -> Int {
        return 4
    }

    func pageView(_ pageView: TCPageView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 25
        case 1:
            return 35
        case 2:
            return 10
        case 3:
            return 15
        default:
            return 0
        }
    }

    func pageView(_ pageView: TCPageView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pageView.dequeueReusableCell(reuseIdentifier: kUICollectionViewCellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor

        return cell
    }
}
```
如果需要点击，那就实现代理
```Swift
extension ViewController: TCPageViewDelegate {

    func pageView(_ pageView: TCPageView, didSelectedAtIndexPath indexPath: IndexPath) {
        print("section:",indexPath.section, "item:", indexPath.item)
    }
}

```

## 安装
1. CocoaPods安装：
```
pod 'TCPageView' 
```
2. 下载ZIP包,将`TCPageView`资源文件拖到工程中。

## 其他
为了不影响您项目中导入的其他第三方库，本库没有依赖任何其他框架，可以放心使用。
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的框架代码看看BUG修复没有）
* 如果您有什么建议可以Issues我，谢谢
* 后续我会持续更新，为它添加更多的功能，欢迎star :)

