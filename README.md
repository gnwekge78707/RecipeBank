# RecipeBank: 面向烹饪爱好者的食谱记录平台

**Project Document**: [detailed docs](https://github.com/gnwekge78707/RecipeBank/tree/master/recipeBank-docs)

| ![Simulator Screen Shot - iPhone 11 - 2022-11-18 at 18.18.37](README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-11-18%20at%2018.18.37.png) | ![Simulator Screen Shot - iPhone 11 - 2022-11-18 at 18.19.05](README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-11-18%20at%2018.19.05.png) | ![Simulator Screen Shot - iPhone 11 - 2022-11-18 at 18.19.48](README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-11-18%20at%2018.19.48.png) |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![Simulator Screen Shot - iPhone 11 - 2022-11-18 at 18.20.19](README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-11-18%20at%2018.20.19.png) | ![Simulator Screen Shot - iPhone 11 - 2022-11-18 at 18.20.51](README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-11-18%20at%2018.20.51.png) | ![Simulator Screen Shot - iPhone 11 - 2022-11-18 at 18.21.35](README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-11-18%20at%2018.21.35.png) |
| ![Simulator Screen Shot - iPhone 11 - 2022-11-18 at 18.21.56](README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-11-18%20at%2018.21.56.png) | ![Simulator Screen Shot - iPhone 11 - 2022-11-18 at 18.23.11](README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-11-18%20at%2018.23.11.png) | ![Simulator Screen Shot - iPhone 11 - 2022-11-20 at 10.10.29](README.assets/Simulator%20Screen%20Shot%20-%20iPhone%2011%20-%202022-11-20%20at%2010.10.29.png) |



## Architecture

```mermaid
flowchart TD
subgraph Views

subgraph RecipeBookView
bb(RecipeBuilderFormView)
bb1(VaryingTextFieldSection)
bb2(...)
end

subgraph RecipeBuilderView
aa(RecipeBookView)
a2(RecipeDetailView)
a3(...)
end

end

subgraph ViewModels
RecipeStoreController(RecipeStoreController-singleton)

subgraph RecipeBookVM
c1(RecipeBook)
end

subgraph RecipeBuilderVM
d1(RecipeBuilder)
end


end

subgraph Model
Recipe(Recipe)
end
d1--持有-->c1
c1--持有-->RecipeStoreController
d1--持有-->RecipeStoreController
RecipeStoreController--持有-->Recipe

RecipeBookView--持有-->RecipeBookVM
RecipeBuilderView--持有-->RecipeBuilderVM
```





## Technologies

- Swift 5
- SwiftUI 2
- Core Data for recipe storage
- UIKit View Controllers for implementing Camera and Photo Library support

## 思路来源和基本需求

在App Store上以“食谱”为关键词搜索，能得到各种大同小异的菜谱软件，此类App大多跟各种菜谱网站的形式类似，用户搜索某种食材或菜肴的名字，并得到具体的食谱。与此同时，随着短视频形式的流媒体平台的兴起，相似的内容更为流行。在此背景下，越来越多人的烹饪水平有所提升，烹饪不仅仅是满足需求层次理论中最低一级的生理需求，更是为了满足自我实现的需求——此时，现有的食谱App往往难以满足这些需求。

以笔者本人为例，在烹饪的过程中，经常会遇到这些问题，而后就会想——要是有下面一款App就好了...需求如下：

- 食谱来源广泛——来自现成食谱、朋友分享、网络视频等，需要以一种统一的格式记录下来。同时，对炒菜、炖菜、红烧、卤水、糖水、中式面点、西式面点等不同食谱，有不同的模式，这里可以引入食谱**模板**的概念，用不同的模板来记录不同种类的食谱。
- 现有的食谱制作出来的效果不一定好，这是因为食材不同导致（如，不同品牌的面粉因为蛋白质含量不同，会对包子、面包等食物成品有较大影响）。很多时候需要对食谱进行修改。
- 有时候，自己自创的一些食谱会有出奇好的效果，这时如果疏于记录，往往后面很难复现。希望能有快速记录的模式。
- 对面点等需要配方比例精准的食谱，希望能够自动计算配方的比例。比如说，某食谱用600g面粉，400g水，5g酵母等等 和成某面团，而我手头只剩400g面粉，这时希望能按比例自动计算出其他各种配料的用量。
- 出于对需求层次理论中最高一级——自我实现需求的满足，很多时候希望对成品进行记录，比如成品图片、视频等。很多时候只是拍摄到手机相册中，查找不便。同时，希望能将食谱以优美的形式导出，以分享给伙伴。

## 基本功能

- 用户可以进行食谱记录：利用提供的默认模板，快速记录下某种食谱的配料和简要制作步骤。
- 用户可以自己创建新的食谱模板，并使用自建的模板记录和改进食谱。
- 用户可以很方便的对食谱进行改进，同时支持保存食谱的历史版本，以便用户研究不同食谱细节对成品的影响。
- 用户可以对面点等需要配方比例精准的食谱，自动计算其配方比例。比如说，某食谱用600g面粉，400g水，5g酵母等等 和成某面团，而我手头只剩400g面粉，用户能按比例自动计算出其他各种配料的用量。
- 用户可以保存食谱的成品图片，导出食谱、分享食谱。

## 扩展功能

- 如有多余时间精力等，希望将其拓展成一个面向烹饪爱好者的食谱分享平台。相比现有平台，更注重专业性，用户能更好的交流。

## 优劣势

- 优点：应用场景真实，笔者本人就希望能够使用这样一款App；实现可行——不像其他需要服务端的平台，现阶段不需要考虑服务端的开发，作为个人项目更为现实，且有更多时间能够细化UI细节、提升用户体验。
- 需要注意：要区分该应用与一般的记事本应用的区别。这可以通过强调食谱模板，食谱比例计算等功能实现。

